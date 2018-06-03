//
//  ThemeSwitchTableViewCell.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

class ThemeSwitchTableViewCell: ThemeTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        self.titleLabel.themes.day.setting(0x444444ff, for: .textColor)
        self.titleLabel.themes.night.setting(0xc7c7c7ff, for: .textColor)
        
        self.iconImageView.themes.day.brightness = 1.0
        self.iconImageView.themes.night.brightness = 0.8

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func themeSwitchValueChanged(_ switch: UIButton) {
        switch Theme.current {
        case .day: Theme.night.apply(animated: true)
        case .night: Theme.day.apply(animated: true)
        default:
            fatalError("Not Supported Theme")
        }
    }

}
