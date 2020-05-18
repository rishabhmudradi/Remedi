//
//  SplashScreenViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/23/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpOrRegisterPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
}

extension SplashScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
