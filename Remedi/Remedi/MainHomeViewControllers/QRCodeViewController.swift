//
//  QRCodeViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class QRCodeViewController: UIViewController {
    var uid:String?
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    @IBOutlet var QRCodeButton: UIButton!
    @IBOutlet var QRCodeImageView: UIImageView!
    @IBOutlet var WhiteCircleImageView: UIImageView!
    @IBOutlet var BottomBarView: UIView!
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QRIntroViewController") as! QRIntroViewController
        do{
            try Auth.auth().signOut()
        } catch {
            print("could not sign out")
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func trackerButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func mapButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PharmacyMapViewController") as! PharmacyMapViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    //TODO: END TIMER AFTER CHANGING VIEWCONTROLLER
    @IBAction func QRCodeButtonPressed(_ sender: Any) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "QRCodeAuthenticateViewController") as! QRCodeAuthenticateViewController
                vc.uid = uid!
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "QRCodeAuthenticateViewController") as! QRCodeAuthenticateViewController
                        vc.modalPresentationStyle = .fullScreen
                        vc.uid = self.uid!
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        }
    }
    
    @IBAction func scanInformationButtonPressed(_ sender: Any) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "QRCodeInfoViewController") as! QRCodeInfoViewController
                vc.uid = uid!
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "QRCodeInfoViewController") as! QRCodeInfoViewController
                        vc.modalPresentationStyle = .fullScreen
                        vc.uid = self.uid!
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimatingCircle()
    }
    
    func startAnimatingCircle() {
        var timer = Timer()
        addExpandingCircle()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("addExpandingCircle"), userInfo: nil, repeats: true)
    }
    
    @objc func addExpandingCircle(){
        var circleImageView = UIImageView()
        circleImageView.image = UIImage(named: "whiteCircle")
        
        QRCodeButton.layer.zPosition = 10
        QRCodeImageView.layer.zPosition = 9
        WhiteCircleImageView.layer.zPosition = 8
        
        view.addSubview(circleImageView)
        circleImageView.layer.zPosition = 7
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        circleImageView.centerYAnchor.constraint(equalTo: WhiteCircleImageView.centerYAnchor).isActive = true
        circleImageView.centerXAnchor.constraint(equalTo: WhiteCircleImageView.centerXAnchor).isActive = true
        var widthOld:NSLayoutConstraint = circleImageView.widthAnchor.constraint(equalToConstant: 172)
        var heightOld:NSLayoutConstraint = circleImageView.heightAnchor.constraint(equalToConstant: 172)
        widthOld.isActive = true
        heightOld.isActive = true
        circleImageView.alpha = 0.7
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.5, animations: {
            widthOld.isActive = false
            heightOld.isActive = false
            circleImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            circleImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            circleImageView.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
}

extension QRCodeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
