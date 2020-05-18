//
//  CalendarTableViewCell.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 11/1/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
    }

}
