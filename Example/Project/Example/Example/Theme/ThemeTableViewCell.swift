//
//  ThemeTableViewCell.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

class ThemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.themeCollection.day.setting(0xffffffff, for: .backgroundColor)
        self.themeCollection.night.setting(0x303030ff, for: .backgroundColor)
        
        self.selectionStyle = .none
        self.contentView.themeCollection.day.setting(0xffffffff, for: .backgroundColor)
        self.contentView.themeCollection.night.setting(0x303030ff, for: .backgroundColor)
        
        self.titleLabel.themeCollection.day.setting(0x444444ff, for: .textColor)
        self.titleLabel.themeCollection.night.setting(0xc7c7c7ff, for: .textColor)
        
        self.iconImageView.themeCollection.day.brightness = 1.0
        self.iconImageView.themeCollection.night.brightness = 0.8

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
