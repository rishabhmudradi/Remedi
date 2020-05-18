//
//  QRIntroViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class QRIntroViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            var user = Auth.auth().currentUser
            
            let ref:DatabaseReference = Database.database().reference()
            ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.hasChild(user!.uid) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
                    vc.uid = user?.uid
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil)
                } else if snapshot.hasChild(user!.uid) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "DoctorHomeViewController") as! DoctorHomeViewController
                    vc.uid = user?.uid
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil)
                } else {
                    do{
                        try Auth.auth().signOut()
                    } catch {
                        print("could not sign out")
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PillIntroViewController") as! PillIntroViewController
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
}

extension QRIntroViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
