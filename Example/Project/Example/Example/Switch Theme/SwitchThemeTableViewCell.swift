//
//  SwitchThemeTableViewCell.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit
import XZTheme

class SwitchThemeTableViewCell: UITableViewCell {

    override func updateAppearance(with newTheme: Theme) {
        switch newTheme {
        case .day:
            self.backgroundColor = UIColor(0xffffffff)
            self.contentView.backgroundColor = UIColor(0xffffffff)
            self.tintColor = UIColor(0x444444ff)
            self.textLabel?.textColor = UIColor(0x444444ff)
            self.selectionStyle = .none
            
        case .night:
            self.backgroundColor = UIColor(0x303030ff)
            self.contentView.backgroundColor = UIColor(0x303030ff)
            self.tintColor = UIColor(0xc7c7c7ff)
            self.textLabel?.textColor = UIColor(0xc7c7c7ff)
            self.selectionStyle = .none
            
        default:
            fatalError("Not supported theme.")
        }
    }

}

class SwitchThemeOptionTableViewCell: SwitchThemeTableViewCell {
    
    override func updateAppearance(with newTheme: Theme) {
        super.updateAppearance(with: newTheme)
        
        guard let themeIdentifier = self.themeIdentifier else { return }
        
        switch themeIdentifier {
        case "day":
            switch newTheme {
            case .day:
                self.imageView?.image = UIImage.init(named: "icon_sun_day")
                self.accessoryType = .checkmark
            case .night:
                self.imageView?.image = UIImage.init(named: "icon_sun_night")
                self.accessoryType = .none
            default:
                break
            }
        case "night":
            switch newTheme {
            case .day:
                self.imageView?.image = UIImage.init(named: "icon_moon_day")
                self.accessoryType = .none
            case .night:
                self.imageView?.image = UIImage.init(named: "icon_moon_night")
                self.accessoryType = .checkmark
            default: break
            }
        default:
            fatalError("")
        }
        
    }
    
}

class SwitchThemeIntroductionTableViewCell: SwitchThemeTableViewCell {
    
    @IBOutlet weak var swiftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var imageView: UIImageView? {
        return swiftImageView
    }
    
    override var textLabel: UILabel? {
        return titleLabel
    }
    
}


