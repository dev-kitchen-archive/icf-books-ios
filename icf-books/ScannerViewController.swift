//
//  ScannerViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ScannerViewController: MasterViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var codeFenceImage: UIImageView!
    @IBOutlet weak var infoLayer: UIVisualEffectView!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var topLayer: UIVisualEffectView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var homeDelegate:HomeViewController?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var lastScannedCode:String = ""
    var readyToScan:Bool = true
    var autorizedCam:Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //check camera access
        autorizedCam = setupWithCameraAccess()
    }
    
    override func viewDidAppear(animated: Bool) {
        if autorizedCam == false {
            ErrorManager.cameraPermission(self)
        }
        if !Reachability.isConnectedToNetwork() {
            ErrorManager.internetPermission(self)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this class is called as soon as a
    func foundNewCode(scannedString:String) {
        
        //animateInfoHeight()
        
        // (1) validate origin
        if let scannedId = Api.idFromUrl(scannedString) {
            infoImage.image = UIImage(named: "ok")
            infoText.text = NSLocalizedString("SCAN_QR_RECOGNIZED", comment:"QR-Code recognized")
            
            // (2) Validate if id already persisted
            if let media = Media.getById(scannedId){
                infoText.text = NSLocalizedString("SCAN_QR_AGAIN", comment:"QR-Code already scanned")

                //as this media content is already available open the detail page
                openDetailViewForMedia(withId: media.valueForKey("id") as! String)
                
            } else if Reachability.isConnectedToNetwork() {
                
                infoText.text = NSLocalizedString("SCAN_LOAD_DATA", comment:"Data is beeing loaded")
                // (3) get data

                RequestManager.getMedia(forMediaId: scannedId, completionHandler: { (media, error) -> (Void) in
                    if error == nil {
                        if let mediaParsed = ParseMedia.fromJson(media!) {
                            self.persistObject(mediaParsed)
                        } else {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.infoText.text = NSLocalizedString("SCAN_PARSE_ERROR", comment:"Error Parsing")
                                self.infoImage.image = UIImage(named: "nok")
                            }
                        }
                    } else {
                        print(error)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.infoText.text = NSLocalizedString("SCAN_SERVER_ERROR", comment:"Error from Server")
                            self.infoImage.image = UIImage(named: "nok")
                        }
                    }
                })

            } else {
                infoImage.image = UIImage(named: "nok")
                infoText.text = NSLocalizedString("SCAN_NO_INTERNET", comment:"No internet to load data")
            }
        } else {
            infoText.text = NSLocalizedString("SCAN_QR_INVALID", comment:"QR-Code is not from valid source")
            infoImage.image = UIImage(named: "nok")
        }
        
        if readyToScan {
            qrCodeFrameView?.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
        
    func persistObject(objectToSave:NSDictionary) {
        if Media.saveNewEntity(objectToSave) {
            openDetailViewForMedia(withId: objectToSave.valueForKey("id") as! String)
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                self.infoText.text = NSLocalizedString("SCAN_SAVED_DATA", comment:"Data was NOT successfully saved")
            }
        }

    }
    
    func openDetailViewForMedia(withId id:String) {
        dispatch_async(dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "DetailPages", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DetailTableView") as! DetailTableViewController
            vc.scan = Media.getById(id)
            self.homeDelegate?.navigationController?.pushViewController(vc, animated: true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    /*
        camera view appending to existing layout from here
    */
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                //only run code if a new qr code was detected
                if metadataObj.stringValue != lastScannedCode {
                    
                    foundNewCode(metadataObj.stringValue)
                    lastScannedCode = metadataObj.stringValue
                }
            }
        }
    }
    
    func setupCamera(){
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        do{
            let input: AVCaptureInput! = try AVCaptureDeviceInput.init(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Place here all views that shall be placed above the camera view
    func placeViewsOverCamera() {
        view.bringSubviewToFront(infoLayer)
        view.bringSubviewToFront(topLayer)
        view.bringSubviewToFront(codeFenceImage)
    }
    
    func setupQrCodeHighlighter() {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor(red:1, green:0.4, blue:0.38, alpha:1).CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
    }
    
    @IBAction func cancelButtonPress(sender: AnyObject) {
        if readyToScan {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            lastScannedCode = ""
            infoText.text = NSLocalizedString("SCAN_QR_SCAN", comment:"Scan the QR-Code")
            //animateInfoHeight()
            
            //TODO: break loading
            print("here you should break the internet loading and coredata saving process")
            readyToScan = !readyToScan
        }
    }
    
//    func animateInfoHeight() {
//        if readyToScan {
//            UIView.animateWithDuration(0.5, animations: {
//                self.heightConstraint.constant = 44
//                self.view.layoutIfNeeded()
//            })
//            
//            codeFenceImage.hidden = true
//            //if not sucessful reload, else hide button
//            cancelButton.titleLabel?.text = "↺"
//        
//            let animatedImg = getAnimation("tick")
//            infoImage.image = animatedImg[animatedImg.count - 1]
//            infoImage.animationImages = animatedImg
//            infoImage.animationDuration = 1.5
//            infoImage.animationRepeatCount = 1
//            infoImage.startAnimating()
//        } else {
//            UIView.animateWithDuration(0.5, animations: {
//                self.heightConstraint.constant = 484
//                self.view.layoutIfNeeded()
//            })
//            codeFenceImage.hidden = false
//            cancelButton.titleLabel?.text = "✕"
//        }
//        
//        readyToScan = !readyToScan
//    }
    
    
    func getAnimation(icon:String) -> [UIImage] {
        var imgListArray:[UIImage] = []
        for countValue in 0...19 {
            let strImageName : String = icon + String(countValue)
            imgListArray.append(UIImage(named:strImageName)!)
        }
        return imgListArray
    }

    /*
     loads camera after ensuring that app has access
     */
    func setupWithCameraAccess() -> Bool? {
        var access:Bool? = nil
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(cameraMediaType)
        
        switch cameraAuthorizationStatus {
            
        // The client is authorized to access the hardware supporting a media type.
        case .Authorized:
            loadCameraView()
            access = true
            break
            
        // The client is not authorized to access the hardware for the media type. The user cannot change
        // the client's status, possibly due to active restrictions such as parental controls being in place.
        case .Restricted:
            access = false
            break
            
        // The user explicitly denied access to the hardware supporting a media type for the client.
        case .Denied:
            access = false
            break
            
        // Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
        case .NotDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccessForMediaType(cameraMediaType) { granted in
                dispatch_async(dispatch_get_main_queue()) {
                    if granted {
                        self.loadCameraView()
                        access = true
                    } else {
                        ErrorManager.cameraPermission(self)
                        access = false
                    }
                }
            }
        }
        
        return access
    }
    
    // loads view after permission check in func setupWithCameraAccess()
    func loadCameraView() {
        setupCamera()
        setupQrCodeHighlighter()
        placeViewsOverCamera()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
