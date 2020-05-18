//
//  InformationViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sideEffectsArray.count)
        return sideEffectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideEffectsTableViewCell") as! SideEffectsTableViewCell
        cell.sideEffectLabel!.text = sideEffectsArray[indexPath.row] as! String
        return cell
    }
    
    var uid:String?
    var medicineID:String?
    var ref:DatabaseReference = Database.database().reference()
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var medicineLabel: UILabel!
    @IBOutlet var activeIngredientLabel: UILabel!
    @IBOutlet var dosageLabel: UILabel!
    @IBOutlet var usageLabel: UILabel!
    @IBOutlet var instructionsLabel: UILabel!
    var sideEffectsArray:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ref.child("medicine").child(medicineID!).observeSingleEvent(of: .value) { (snapshot) in
            let medicineData = snapshot.value as! NSMutableDictionary
            
            self.medicineLabel.text = medicineData.value(forKey: "name") as! String
            self.activeIngredientLabel.text = medicineData.value(forKey: "activeIngredient") as! String
            let dosage = medicineData.value(forKey: "dosage") as! NSMutableDictionary
            self.dosageLabel.text = String(dosage.value(forKey: "count") as! Int) + " per " + String(dosage.value(forKey: "hours") as! Int) + " hours"
            self.usageLabel.text = medicineData.value(forKey: "usage") as! String
            self.instructionsLabel.text = medicineData.value(forKey: "ingesting") as! String
            self.sideEffectsArray = medicineData.value(forKey: "sideEffects") as! NSMutableArray
            self.tableView.reloadData()
        }
    }
    @IBAction func continueButtonPressed(_ sender: Any) {
        returnToQRCodePage()
    }
    func returnToQRCodePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QRCodeViewController") as! QRCodeViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
