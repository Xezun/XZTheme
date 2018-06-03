//
//  ThemeTableView.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class ThemeTableView: UITableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.themes.day.backgroundColor = UIColor(0xffffffff)
        self.themes.night.backgroundColor = UIColor(0x303030ff)
        
        self.themes.day.setting(0xeeeeeeff, for: .separatorColor)
        self.themes.night.setting(0xc7c7c7ff, for: .separatorColor)
    }

}
