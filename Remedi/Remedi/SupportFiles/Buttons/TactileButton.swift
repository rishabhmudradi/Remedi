//
//  TactileButton.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class TactileButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.layer.shadowOffset = CGSize(width: self.layer.shadowOffset.width*0.5, height: self.layer.shadowOffset.height*0.5)
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.layer.shadowOffset = CGSize(width: self.layer.shadowOffset.width*2, height: self.layer.shadowOffset.height*2)
        }, completion: {finished in
            
        })
        super.touchesEnded(touches, with: event)
    }
}
