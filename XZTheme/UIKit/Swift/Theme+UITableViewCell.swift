//
//  Theme+UITableViewCell.swift
//  XZTheme
//
//  Created by mlibai on 2018/6/3.
//

import Foundation
import XZKit

extension Theme.State {
    
}


extension Theme.Style {
    
    public func tableViewCellSelectionStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UITableViewCellSelectionStyle {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return .default }
        if let tableViewCellSelectionStyle = value as? UITableViewCellSelectionStyle {
            return tableViewCellSelectionStyle
        }
        if let number = value as? Int, let tableViewCellSelectionStyle = UITableViewCellSelectionStyle(rawValue: number) {
            return tableViewCellSelectionStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default":   return .default
            case "none": return .none
            case "gray":   return .gray
            case "blue":    return .blue
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITableViewCellSelectionStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
    
}

extension UITableViewCell {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.contentView.backgroundColor = themeStyles.backgroundColor
        }
        
    }
}
