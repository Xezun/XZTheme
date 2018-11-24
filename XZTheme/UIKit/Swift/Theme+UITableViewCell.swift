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
    
    public func tableViewCellSelectionStyle(for themeAttribute: Theme.Attribute) -> UITableViewCell.SelectionStyle {
        guard let value = self.value(for: themeAttribute) else { return .default }
        if let tableViewCellSelectionStyle = value as? UITableViewCell.SelectionStyle {
            return tableViewCellSelectionStyle
        }
        if let number = value as? Int, let tableViewCellSelectionStyle = UITableViewCell.SelectionStyle(rawValue: number) {
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
    
    public func tableViewCellAccessoryType(for themeAttribute: Theme.Attribute) -> UITableViewCell.AccessoryType {
        guard let value = self.value(for: themeAttribute) else { return .none }
        if let tableViewCellAccessoryType = value as? UITableViewCell.AccessoryType {
            return tableViewCellAccessoryType
        }
        if let number = value as? Int, let tableViewCellAccessoryType = UITableViewCell.AccessoryType(rawValue: number) {
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
    
    
    var selectionStyle: UITableViewCell.SelectionStyle {
        get { return tableViewCellSelectionStyle(for: .selectionStyle) }
        set { setValue(newValue, for: .selectionStyle) }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        get { return tableViewCellAccessoryType(for: .accessoryType) }
        set { setValue(newValue, for: .accessoryType) }
    }
    
    var contentBackgroundColor: UIColor? {
        get { return color(for: .contentBackgroundColor) }
        set { setValue(newValue, for: .contentBackgroundColor) }
    }
    
    var selectedBackgroundColor: UIColor? {
        get { return color(for: .selectedBackgroundColor) }
        set { setValue(newValue, for: .selectedBackgroundColor) }
    }
    
    var multipleSelectionBackgroundColor: UIColor? {
        get { return color(for: .multipleSelectionBackgroundColor) }
        set { setValue(newValue, for: .multipleSelectionBackgroundColor) }
    }
}

extension UITableViewCell {
    
    
    /// 设置背景色会同时设置 backgroundView 的背景色。
    ///
    /// - Parameter themeStyles: 主题样式集。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.selectionStyle) {
            self.selectionStyle = themeStyles.selectionStyle
        }
        
        if themeStyles.contains(.backgroundColor) {
            self.backgroundView?.backgroundColor = themeStyles.backgroundColor
        }
        
        if themeStyles.contains(.contentBackgroundColor) {
            self.contentView.backgroundColor = themeStyles.contentBackgroundColor
        }
        
        if themeStyles.contains(.selectedBackgroundColor) {
            self.selectedBackgroundView?.backgroundColor = themeStyles.selectedBackgroundColor
        }
        
        if themeStyles.contains(.multipleSelectionBackgroundColor) {
            self.multipleSelectionBackgroundView?.backgroundColor = themeStyles.multipleSelectionBackgroundColor
        }
        
        if themeStyles.contains(.accessoryType) {
            self.accessoryType = themeStyles.accessoryType
        }
    }
}
