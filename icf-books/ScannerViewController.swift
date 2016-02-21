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

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var codeFenceImage: UIImageView!
    @IBOutlet weak var infoCancelLayer: UIVisualEffectView!
    @IBOutlet weak var infoText: UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var lastScannedCode:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCamera()
        placeViewsOverCamera()
        setupQrCodeHighlighter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this class is called as soon as a
    func foundNewCode(scannedString:String) {
        
        // (1) validate origin
        if scannedString.rangeOfString(apiBaseUrl as String) != nil {
            infoText.text = "ICF QR Code gefunden."
            
            // (2) Validate if id already persisted
            //...Media Class get by id != nil

            // (2) get data from url
            let scannedURL = NSURL(string: scannedString)
            if scannedURL != nil {
                dataRetrieve(scannedURL!)
            }
        } else {
            infoText.text = "QR Code nicht aus dem ICF Buch."
        }
        
        qrCodeFrameView?.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func dataRetrieve(scannedURL: NSURL) {
        GetJson.retrieveDictFrom(scannedURL, completionHandler: { (jsonDict:NSDictionary?, jsonError:GetJSONDataError?) in
            if jsonError == nil && jsonDict != nil {
                // (3) Parse Json
                self.infoText.text = "Daten wurden vom Server empfangen und nun werden die Medien geladen."
                self.infoText.textColor = UIColor.greenColor()
                let media = ParseMedia.fromJson(jsonDict!)
                self.persistObject(media)
            } else {
                // handle error
            }
        })
    }
    
    func persistObject(objectToSave:NSDictionary){
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Media", inManagedObjectContext:managedContext)
        
        let media = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3
        media.setValue(objectToSave.valueForKey("id"), forKey: "id")
        media.setValue(objectToSave.valueForKey("type"), forKey: "type")
        media.setValue(objectToSave.valueForKey("title"), forKey: "title")
        media.setValue(objectToSave.valueForKey("teaser"), forKey: "teaser")
        media.setValue(objectToSave.valueForKey("thumbnailUrl"), forKey: "thumbnail_url")
        media.setValue(objectToSave.valueForKey("fileUrl"), forKey: "file_url")
        media.setValue(objectToSave.valueForKey("thumbnailData"), forKey: "thumbnail_data")
        
        //4
        do {
            try managedContext.save()
            //5 update here list or just load whole data new...
            //people.append(person)
            print("Successfully saved in core data")
            infoText.text = "Daten erfolgreich geladen."
            infoText.textColor = UIColor.greenColor()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
                    
                    lastScannedCode = metadataObj.stringValue
                    foundNewCode(metadataObj.stringValue)
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
        view.bringSubviewToFront(infoCancelLayer)
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
        self.dismissViewControllerAnimated(true, completion: nil)
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
