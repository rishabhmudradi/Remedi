//
//  FraudViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class FraudViewController: UIViewController {
    var uid:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continueButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QRCodeViewController") as! QRCodeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.uid = uid!
        self.present(vc, animated: true, completion: nil)
    }
}
