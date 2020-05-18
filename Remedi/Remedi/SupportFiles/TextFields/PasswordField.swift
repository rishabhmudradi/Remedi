//
//  PasswordField.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/29/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class PasswordField: CustomTextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLeftView()
    }
    
    func setUpLeftView() {
        leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "password")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 35))
        view.addSubview(imageView)
        leftView = view
        reloadInputViews()
    }
}
