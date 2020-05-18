//
//  AddMedicineQRViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/1/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase
class AddMedicineQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var uid:String?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var ref:DatabaseReference = Database.database().reference()
    
    @IBOutlet var cancelButton: RedPrimaryButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        returnToTrackerView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.zPosition = 10
        
        setUpCamera()
    }
    
    func setUpCamera(){
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Could not access camera")
            returnToTrackerView()
            return
        }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(captureDeviceInput)
        } catch {
            print(error)
            returnToTrackerView()
            return
        }
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetaDataOutput)
        
        captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height)
        view.layer.addSublayer(videoPreviewLayer!)
        videoPreviewLayer?.zPosition = 0
        captureSession?.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count != 0 {
            var metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if metadataObject.type == AVMetadataObject.ObjectType.qr {
                
                captureSession?.stopRunning()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "AddInfoViewController") as! AddInfoViewController
                vc.modalPresentationStyle = .fullScreen
                vc.uid = self.uid
                vc.medicineID = metadataObject.stringValue
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    func returnToTrackerView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.modalPresentationStyle = .fullScreen
        vc.uid = self.uid
        self.present(vc, animated: true, completion: nil)
    }
}
