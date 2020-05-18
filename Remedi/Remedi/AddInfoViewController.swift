//
//  AddInfoViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/1/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideEffectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideEffectsTableViewCell") as! SideEffectsTableViewCell
        cell.sideEffectLabel!.text = sideEffectsArray[indexPath.row] as! String
        return cell
    }
    
    var uid:String?
    var medicineID:String?
    @IBOutlet var activeIngredientLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dosageLabel: UILabel!
    @IBOutlet var usageLabel: UILabel!
    @IBOutlet var instructionLabel: UILabel!
    var sideEffectsArray:NSMutableArray = []
    @IBOutlet var tableView: UITableView!
    
    var ref:DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ref.child("medicine").child(medicineID!).observeSingleEvent(of: .value) { (snapshot) in
            let medicineData = snapshot.value as! NSMutableDictionary
            
            self.nameLabel.text = medicineData.value(forKey: "name") as! String
            self.activeIngredientLabel.text = medicineData.value(forKey: "activeIngredient") as! String
            let dosage = medicineData.value(forKey: "dosage") as! NSMutableDictionary
            self.dosageLabel.text = String(dosage.value(forKey: "count") as! Int) + " per " + String(dosage.value(forKey: "hours") as! Int) + " hours"
            self.usageLabel.text = medicineData.value(forKey: "usage") as! String
            self.instructionLabel.text = medicineData.value(forKey: "ingesting") as! String
            self.sideEffectsArray = medicineData.value(forKey: "sideEffects") as! NSMutableArray
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        returnToTrackerView()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FinalizeMedicineViewController") as! FinalizeMedicineViewController
        vc.modalPresentationStyle = .fullScreen
        vc.uid = self.uid
        vc.medicineID = self.medicineID
        self.present(vc, animated: true, completion: nil)
    }
    
    func returnToTrackerView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.modalPresentationStyle = .fullScreen
        vc.uid = self.uid
        self.present(vc, animated: true, completion: nil)
    }
}
