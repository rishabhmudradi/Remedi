//
//  AddPatientViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/22/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseDatabase
class AddPatientViewController: UIViewController {
    var uid:String?
    @IBOutlet var textField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addPatientButtonPressed(_ sender: Any) {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: "DoctorHomeViewController") as! DoctorHomeViewController
        vc.uid = uid
        
        vc.modalPresentationStyle = .fullScreen
        
        var ref:DatabaseReference = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
            let userDictionary = snapshot.value as! NSMutableDictionary
            
            var userUIDKey = [String: String]()
            for (key, value) in userDictionary {
                userUIDKey[String((key as! String).prefix(5))] = key as! String
            }
            
            if let patientUID = userUIDKey[self.textField.text!] {
                ref.child("doctors").child(self.uid!).child("patients").observeSingleEvent(of: .value) { (snapshot) in
                    let patientArray = snapshot.value as! NSMutableArray
                    if(patientArray.contains(patientUID)) {
                        
                    } else {
                        patientArray.add(patientUID)
                        ref.child("doctors").child(self.uid!).child("patients").setValue(patientArray)
                    }
                }
                self.present(vc, animated: false, completion: nil)
            } else {
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: "DoctorHomeViewController") as! DoctorHomeViewController
        vc.uid = uid
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
