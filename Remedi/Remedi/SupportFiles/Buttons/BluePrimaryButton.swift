//
//  BluePrimaryButton.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class BluePrimaryButton: TactileButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        backgroundColor = Colors.bluePrimary
        setTitleColor(Colors.white, for: .normal)
        layer.cornerRadius = 15
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        layer.shadowColor = Colors.bluePrimary.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.7
    }
}
