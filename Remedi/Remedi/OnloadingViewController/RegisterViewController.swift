//
//  RegisterViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    private var ref:DatabaseReference = Database.database().reference()
    
    @IBOutlet var nameTextField: CustomTextField!
    @IBOutlet var ageTextField: CustomTextField!
    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var passwordTextField: CustomTextField!
    @IBOutlet var repeatPasswordTextField: CustomTextField!
    @IBOutlet var doctorSwitch: UISwitch!
    
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        register()
    }
    
    func register(){
        if let name = nameTextField.text{
            if let age = ageTextField.text{
                if let email = emailTextField.text{
                    if let password = passwordTextField.text{
                        Auth.auth().createUser(withEmail: email, password: password) { (userObject, error) in
                            if !self.doctorSwitch.isOn {
                                if let user = userObject?.user {
                                    let weekObject = ["monday":"none", "tuesday":"none", "wednesday":"none", "thursday":"none", "friday":"none", "saturday":"none", "sunday":"none"]
                                    let userObject = ["name":name, "age":age, "email":email, "tracker":weekObject] as [String : Any]
                                    self.ref.child("users").child(user.uid).setValue(userObject)
                                    self.goToHomeScreen(uid: user.uid)
                                } else {
                                    print(error)
                                    return
                                }
                            } else {
                                if let user = userObject?.user {
                                    let patientUIDObject = ["empty"]
                                    let userObject = ["name":name, "age":age, "email":email, "patients": patientUIDObject] as [String : Any]
                                    
                                    self.ref.child("doctors").child(user.uid).setValue(userObject)
                                    self.goToDoctorHomeScreen(uid: user.uid)
                                } else {
                                    print(error)
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
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
    
    func goToDoctorHomeScreen(uid: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DoctorHomeViewController") as! DoctorHomeViewController
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.uid = uid

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RegisterViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
