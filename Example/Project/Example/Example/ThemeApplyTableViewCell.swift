//
//  ThemeApplyTableViewCell.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class ThemeApplyTableViewCell: UITableViewCell {
    
    static let isThemeLoaded: Bool = {
        return true
    } ()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.themes.day.setting(0xffffffff, for: .backgroundColor)
        self.themes.night.setting(0x303030ff, for: .backgroundColor)
        
        self.selectionStyle = .none
        
        self.themes.day.tintColor = UIColor(0x333333ff)
        self.themes.night.tintColor = UIColor(0xc7c7c7ff)
        
        self.contentView.themes.day.backgroundColor = .white
        self.contentView.themes.night.backgroundColor = UIColor(0x303030ff)
        
        self.textLabel?.themes.day.textColor = UIColor(0x444444ff)
        self.textLabel?.themes.night.textColor = UIColor(0xc7c7c7ff)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
