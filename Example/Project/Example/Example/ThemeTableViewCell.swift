//
//  ThemeTableViewCell.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.themes.day.setting(0xffffffff, for: .backgroundColor)
        self.themes.night.setting(0x303030ff, for: .backgroundColor)
        
        self.selectionStyle = .none
        self.contentView.themes.day.setting(0xffffffff, for: .backgroundColor)
        self.contentView.themes.night.setting(0x303030ff, for: .backgroundColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
