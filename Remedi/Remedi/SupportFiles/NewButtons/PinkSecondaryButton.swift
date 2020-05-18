//
//  WhiteSecondaryButton.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class PinkSecondaryButton: TactileButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        backgroundColor = Colors.transparent
        setTitleColor(Colors.pinkPrimary, for: .normal)
        layer.cornerRadius = 15
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        layer.borderWidth = 2
        layer.borderColor = Colors.pinkPrimary.cgColor
    }
}
