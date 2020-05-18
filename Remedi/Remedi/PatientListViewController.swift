//
//  PatientListViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/23/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class PatientListViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sundayPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WarningViewController") as! WarningViewController
        
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: false, completion: nil)
    }
}

extension PatientListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
