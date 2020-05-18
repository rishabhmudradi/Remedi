//
//  PillIntroViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class PillIntroViewController: UIViewController {
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MapIntroViewController") as! MapIntroViewController
        
        presentTransition = RightToLeftTransition()
        dismissTransition = LeftToRightTransition()

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self

        present(vc, animated: true, completion: { [weak self] in
            self?.presentTransition = nil
        })
    }
}

extension PillIntroViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
