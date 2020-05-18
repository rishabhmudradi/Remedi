//
//  BlueSimpleButton.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class BlueSimpleButton: TactileButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        backgroundColor = Colors.pinkPrimary
        setTitleColor(Colors.white, for: .normal)
        layer.cornerRadius = 15
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
}
