//
//  ProfileViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/23/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
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
}
