//
//  AuthenticMedicineViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AuthenticMedicineViewController: UIViewController {
    var uid:String?
    var medicineID:String?
    var ref:DatabaseReference = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didNotPurchaseButtonPressed(_ sender: Any) {
        returnToQRCodePage()
    }
    @IBAction func PurchaseButtonPressed(_ sender: Any) {
        ref.child("medicine").child(medicineID!).child("scanned").setValue(true)
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
