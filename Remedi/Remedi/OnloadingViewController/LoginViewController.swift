//
//  LoginViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class LoginViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    @IBOutlet var emailTextField: EmailField!
    @IBOutlet var passwordTextField: PasswordField!
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { (userObject, error) in
                    if let user = userObject?.user {
                        let ref:DatabaseReference = Database.database().reference()
                        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
                            if snapshot.hasChild(user.uid) {
                                self.goToHomeScreen(uid: user.uid)
                            } else {
                                self.goToDoctorScreen(uid: user.uid)
                            }
                        }
                    } else {
                        print(error)
                        return
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func goToHomeScreen(uid: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.uid = uid

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    func goToDoctorScreen(uid: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewControllerGang")
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
