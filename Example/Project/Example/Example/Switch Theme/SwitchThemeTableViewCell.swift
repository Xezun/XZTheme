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

    class func lazyLoadThemeStyles(forTheme theme: Theme, forThemeIdentifier themeIdentifier: Theme.Identifier) -> Bool {
        guard self == SwitchThemeTableViewCell.self else {
            return false
        }
        XZLog("`%@` lazy load theme styles for `%@` `%@`. \n", self, theme, themeIdentifier)
        switch theme {
        case .day:
            SwitchThemeTableViewCell.themes.day
                .setting(0xffffffff, for: .backgroundColor)
                .setting(0xffffffff, for: .contentBackgroundColor)
                .setting(0x444444ff, for: .tintColor)
                .setting(0x444444ff, for: .textColor)
                .setting(UITableViewCellSelectionStyle.none, for: .selectionStyle)
            
        case .night:
            SwitchThemeTableViewCell.themes.night
                .setting(0x303030ff, for: .backgroundColor)
                .setting(0x303030ff, for: .contentBackgroundColor)
                .setting(0xc7c7c7ff, for: .tintColor)
                .setting(0xc7c7c7ff, for: .textColor)
                .setting(UITableViewCellSelectionStyle.none, for: .selectionStyle)
            
        default:
            fatalError("Not supported Theme.")
        }
        
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.image) {
            self.imageView?.image = themeStyles.image
        }
        
        if themeStyles.containsThemeAttribute(.textColor) {
            self.textLabel?.textColor = themeStyles.textColor
        }
        
    }
}

class SwitchThemeOptionTableViewCell: SwitchThemeTableViewCell {
    
    override class func lazyLoadThemeStyles(forTheme theme: Theme, forThemeIdentifier themeIdentifier: Theme.Identifier) -> Bool {
        guard self == SwitchThemeOptionTableViewCell.self else {
            return false
        }
        switch theme {
        case .day:
            SwitchThemeOptionTableViewCell.themes(forThemeIdentifier: "day").day
                .setting("icon_sun_day", for: .image)
                .setting(UITableViewCellAccessoryType.checkmark, for: .accessoryType)
            SwitchThemeOptionTableViewCell.themes(forThemeIdentifier: "night").day
                .setting("icon_moon_day", for: .image)
                .setting(UITableViewCellAccessoryType.none, for: .accessoryType)
        case .night:
            SwitchThemeOptionTableViewCell.themes(forThemeIdentifier: "day").night
                .setting("icon_sun_night", for: .image)
                .setting(UITableViewCellAccessoryType.none, for: .accessoryType)
            SwitchThemeOptionTableViewCell.themes(forThemeIdentifier: "night").night
                .setting("icon_moon_night", for: .image)
                .setting(UITableViewCellAccessoryType.checkmark, for: .accessoryType)
        default:
            fatalError("Not Supported theme.")
        }
        return true
    }
    
    override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.contentView.backgroundColor = themeStyles.backgroundColor
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
    
    override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.titleLabel.backgroundColor = themeStyles.backgroundColor
        }
    }
    
}


