//
//  FinalizeMedicineViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/1/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FinalizeMedicineViewController: UIViewController {
    var uid:String?
    var medicineID:String?
    var ref:DatabaseReference = Database.database().reference()
    @IBOutlet var sunday: UIButton!
    @IBOutlet var monday: UIButton!
    @IBOutlet var tuesday: UIButton!
    @IBOutlet var wednesday: UIButton!
    @IBOutlet var thursday: UIButton!
    @IBOutlet var friday: UIButton!
    @IBOutlet var saturday: UIButton!
    @IBOutlet var addLabel: UILabel!
    @IBOutlet var timePicker: UIDatePicker!
    var medicineName:String = ""
    var dayArray:[Bool] = [false, false, false, false, false, false, false]
    var days:[String] = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    
    @IBAction func sundayPressed(_ sender: Any) {
        dayArray[0] = !dayArray[0]
        if(dayArray[0]) {
            sunday.backgroundColor = Colors.lightPink
            sunday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            sunday.backgroundColor = UIColor.white
            sunday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func mondayPressed(_ sender: Any) {
        dayArray[1] = !dayArray[1]
        if(dayArray[1]) {
            monday.backgroundColor = Colors.lightPink
            monday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            monday.backgroundColor = UIColor.white
            monday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func tuesdayPressed(_ sender: Any) {
        dayArray[2] = !dayArray[2]
        if(dayArray[2]) {
            tuesday.backgroundColor = Colors.lightPink
            tuesday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            tuesday.backgroundColor = UIColor.white
            tuesday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func wednesdayPressed(_ sender: Any) {
        dayArray[3] = !dayArray[3]
        if(dayArray[3]) {
            wednesday.backgroundColor = Colors.lightPink
            wednesday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            wednesday.backgroundColor = UIColor.white
            wednesday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func thursdayPressed(_ sender: Any) {
        dayArray[4] = !dayArray[4]
        if(dayArray[4]) {
            thursday.backgroundColor = Colors.lightPink
            thursday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            thursday.backgroundColor = UIColor.white
            thursday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func fridayPressed(_ sender: Any) {
        dayArray[5] = !dayArray[5]
        if(dayArray[5]) {
            friday.backgroundColor = Colors.lightPink
            friday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            friday.backgroundColor = UIColor.white
            friday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func saturdayPressed(_ sender: Any) {
        dayArray[6] = !dayArray[6]
        if(dayArray[6]) {
            saturday.backgroundColor = Colors.lightPink
            saturday.setTitleColor(Colors.pinkPrimary, for: .normal)
        } else {
            saturday.backgroundColor = UIColor.white
            saturday.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sunday.layer.cornerRadius = 5
        monday.layer.cornerRadius = 5
        tuesday.layer.cornerRadius = 5
        wednesday.layer.cornerRadius = 5
        thursday.layer.cornerRadius = 5
        friday.layer.cornerRadius = 5
        saturday.layer.cornerRadius = 5
        
        fetchData()
    }
    
    func fetchData() {
        ref.child("medicine").child(medicineID!).child("name").observeSingleEvent(of: .value) { (snapshot) in
            
            self.addLabel.text = "Add " + String(snapshot.value as! String)
            self.medicineName = String(snapshot.value as! String)
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        returnToTrackerView()
    }
    func returnToTrackerView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.modalPresentationStyle = .fullScreen
        vc.uid = self.uid
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        ref.child("users").child(uid!).child("tracker").observeSingleEvent(of: .value) { (snapshot) in
            var currentTracker = snapshot.value as! NSMutableDictionary
            var count = 0
            for day in self.dayArray {
                if(day) {
                    if(String(currentTracker.value(forKey: self.days[count]) as! String) == "none"){
                        currentTracker.setValue(self.medicineName + " 5pm", forKey: self.days[count])
                        //currentTracker.setValue(self.medicineName + " " + self.timePicker.date.description, forKey: self.days[count])
                    } else {
                        currentTracker.setValue(String(currentTracker.value(forKey: self.days[count]) as! String) + ", " + self.medicineName + " 5pm", forKey: self.days[count])
                        //currentTracker.setValue(", " + self.medicineName + " " + self.timePicker.date.description, forKey: self.days[count])
                    }
                }
                count += 1
            }
            self.ref.child("users").child(self.uid!).child("tracker").setValue(currentTracker)
            self.returnToTrackerView()
        }
    }
}
