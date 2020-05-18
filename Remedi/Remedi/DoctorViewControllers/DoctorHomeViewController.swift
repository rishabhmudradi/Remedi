//
//  DoctorHomeViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/21/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class DoctorHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell") as! PatientTableViewCell
        cell.patientNameLabel.text = patientNameList[indexPath.row]
        return cell
    }
    
    var uid:String?
    @IBOutlet var tableView: UITableView!
    var patientList:[String] = []
    var patientNameList:[String] = []
    
    @IBAction func logOutButton(_ sender: Any) {
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
    @IBAction func addPatientButtonPressed(_ sender: Any) {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: "AddPatientViewController") as! AddPatientViewController
        vc.uid = uid
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref:DatabaseReference = Database.database().reference()
        ref.child("doctors").child(uid!).child("patients").observeSingleEvent(of: .value) { (snapshot) in
            let patientArray = snapshot.value as! NSMutableArray
            for patientObject in patientArray {
                let patient = patientObject as! String
                
                if (patient != "empty") {
                    self.patientList.append(patient)
                }
            }
            var count = 0
            print(self.patientList.count)
            for patient in self.patientList {
                ref.child("users").child(patient).child("name").observeSingleEvent(of: .value) { (snapshot) in
                    self.patientNameList.append(snapshot.value as! String)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
