//
//  QRCodeInfoViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase

class QRCodeInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var uid:String?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var ref:DatabaseReference = Database.database().reference()
    
    @IBOutlet var cancelButton: RedPrimaryButton!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        returnToQRCodePage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.zPosition = 10
        setUpCamera()
    }
    
    
    func setUpCamera(){
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Could not access camera")
            returnToQRCodePage()
            return
        }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(captureDeviceInput)
        } catch {
            print(error)
            returnToQRCodePage()
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
                ref.child("medicine").child(metadataObject.stringValue!).observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.exists() {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "InformationViewController") as! InformationViewController
                        vc.medicineID = metadataObject.stringValue!
                        vc.uid = self.uid
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "FraudViewController") as! FraudViewController
                        vc.modalPresentationStyle = .fullScreen
                        vc.uid = self.uid!
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func returnToQRCodePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QRCodeViewController") as! QRCodeViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
