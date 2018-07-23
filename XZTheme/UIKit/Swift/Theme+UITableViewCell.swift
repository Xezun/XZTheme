//
//  Theme+UITableViewCell.swift
//  XZTheme
//
//  Created by mlibai on 2018/6/3.
//

import Foundation
import XZKit

extension Theme.Attribute {
    
    /// UITableViewCell
    public static let selectionStyle = Theme.Attribute.init(rawValue: "selectionStyle")
    /// UITableViewCell
    public static let accessoryType = Theme.Attribute.init(rawValue: "accessoryType")
    /// For the UITableViewCell.contentView's backgroundColor.
    public static let contentBackgroundColor = Theme.Attribute.init(rawValue: "contentBackgroundColor")
    /// For the UITableViewCell.selectedBackgrondView's backgroundColor.
    public static let selectedBackgroundColor = Theme.Attribute.init(rawValue: "selectedBackgroundColor")
    /// For the UITableViewCell.multipleSelectionBackgroundView's backgroundColor.
    public static let multipleSelectionBackgroundColor = Theme.Attribute.init(rawValue: "multipleSelectionBackgroundColor")
    
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
            case "default": return .default
            case "none":    return .none
            case "gray":    return .gray
            case "blue":    return .blue
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITableViewCellSelectionStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
    public func tableViewCellAccessoryType(forThemeAttribute themeAttribute: Theme.Attribute) -> UITableViewCellAccessoryType {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return .none }
        if let tableViewCellAccessoryType = value as? UITableViewCellAccessoryType {
            return tableViewCellAccessoryType
        }
        if let number = value as? Int, let tableViewCellAccessoryType = UITableViewCellAccessoryType(rawValue: number) {
            return tableViewCellAccessoryType
        }
        if let aString = value as? String {
            switch aString {
            case "none":                   return .none
            case "disclosureIndicator":    return .disclosureIndicator
            case "detailDisclosureButton": return .detailDisclosureButton
            case "checkmark":              return .checkmark
            case "detailButton":           return .detailButton
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITableViewCellAccessoryType value, `.none` returned.", value, themeAttribute)
        return .none
    }
    
    
    var selectionStyle: UITableViewCellSelectionStyle {
        get { return tableViewCellSelectionStyle(forThemeAttribute: .selectionStyle) }
        set { setValue(newValue, forThemeAttribute: .selectionStyle) }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        get { return tableViewCellAccessoryType(forThemeAttribute: .accessoryType) }
        set { setValue(newValue, forThemeAttribute: .accessoryType) }
    }
    
    var contentBackgroundColor: UIColor? {
        get { return color(forThemeAttribute: .contentBackgroundColor) }
        set { setValue(newValue, forThemeAttribute: .contentBackgroundColor) }
    }
    
    var selectedBackgroundColor: UIColor? {
        get { return color(forThemeAttribute: .selectedBackgroundColor) }
        set { setValue(newValue, forThemeAttribute: .selectedBackgroundColor) }
    }
    
    var multipleSelectionBackgroundColor: UIColor? {
        get { return color(forThemeAttribute: .multipleSelectionBackgroundColor) }
        set { setValue(newValue, forThemeAttribute: .multipleSelectionBackgroundColor) }
    }
}

extension UITableViewCell {
    
    
    /// 设置背景色会同时设置 backgroundView 的背景色。
    ///
    /// - Parameter themeStyles: 主题样式集。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.selectionStyle) {
            self.selectionStyle = themeStyles.selectionStyle
        }
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.backgroundView?.backgroundColor = themeStyles.backgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.contentBackgroundColor) {
            self.contentView.backgroundColor = themeStyles.contentBackgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.selectedBackgroundColor) {
            self.selectedBackgroundView?.backgroundColor = themeStyles.selectedBackgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.multipleSelectionBackgroundColor) {
            self.multipleSelectionBackgroundView?.backgroundColor = themeStyles.multipleSelectionBackgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.accessoryType) {
            self.accessoryType = themeStyles.accessoryType
        }
    }
}
