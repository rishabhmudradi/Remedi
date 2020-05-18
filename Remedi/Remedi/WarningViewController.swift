//
//  WarningViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/23/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func okayButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PatientListViewController") as! PatientListViewController
        
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: false, completion: nil)
    }
}
