//
//  Theme+UITableView.swift
//  Pods-Example
//
//  Created by mlibai on 2018/5/3.
//

import UIKit
import XZKit

extension Theme.Attribute {
    
    /// UITableView.
    public static let sectionIndexColor = Theme.Attribute.init(rawValue: "sectionIndexColor")
    /// UITableView.sectionIndexBackgroundColor
    public static let sectionIndexBackgroundColor = Theme.Attribute.init(rawValue: "sectionIndexBackgroundColor")
    /// UITableView.sectionIndexTrackingBackgroundColor
    public static let sectionIndexTrackingBackgroundColor = Theme.Attribute.init(rawValue: "sectionIndexTrackingBackgroundColor")
    /// UITableView.separatorStyle
    public static let separatorStyle = Theme.Attribute.init(rawValue: "separatorStyle")
    /// UITableView.separatorColor
    public static let separatorColor = Theme.Attribute.init(rawValue: "separatorColor")
}

extension Theme.Style {
    
    /// 获取已设置的主题属性值：UITableViewCellSeparatorStyle 。如下值将可以自动转换。
    /// 1. UITableViewCellSeparatorStyle 原始值（Int）。
    /// 2. 字符串 none、singleLine、singleLineEtched 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    public func tableViewCellSeparatorStyle(for themeAttribute: Theme.Attribute) -> UITableViewCellSeparatorStyle {
        guard let value = value(for: themeAttribute) else { return .singleLine }
        if let separatorStyle = value as? UITableViewCellSeparatorStyle {
            return separatorStyle
        }
        if let number = value as? Int, let separatorStyle = UITableViewCellSeparatorStyle.init(rawValue: number) {
            return separatorStyle
        }
        if let aString = value as? String {
            switch aString {
            case "none":                return .none
            case "singleLine":          return .singleLine
            case "singleLineEtched":    return .singleLineEtched
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UITableViewCellSeparatorStyle value, `.singleLine` returned.", value, themeAttribute)
        return .singleLine
    }
    


    public var sectionIndexColor: UIColor? {
        get { return color(for: .sectionIndexColor) }
        set { setValue(newValue, for: .sectionIndexColor) }
    }
    
    public var sectionIndexBackgroundColor: UIColor? {
        get { return color(for: .sectionIndexBackgroundColor) }
        set { setValue(newValue, for: .sectionIndexBackgroundColor) }
    }
    
    public var sectionIndexTrackingBackgroundColor: UIColor? {
        get { return color(for: .sectionIndexTrackingBackgroundColor) }
        set { setValue(newValue, for: .sectionIndexTrackingBackgroundColor) }
    }
    
    public var separatorStyle: UITableViewCellSeparatorStyle {
        get { return tableViewCellSeparatorStyle(for: .separatorStyle)  }
        set { setValue(newValue, for: .separatorStyle) }
    }
    
    public var separatorColor: UIColor? {
        get { return color(for: .separatorColor) }
        set { setValue(newValue, for: .separatorColor) }
    }
    
}

extension UITableView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.sectionIndexColor) {
            self.sectionIndexColor = themeStyles.sectionIndexColor
        }
        
        if themeStyles.contains(.sectionIndexBackgroundColor) {
            self.sectionIndexBackgroundColor = themeStyles.sectionIndexBackgroundColor
        }
        
        if themeStyles.contains(.sectionIndexTrackingBackgroundColor) {
            self.sectionIndexTrackingBackgroundColor = themeStyles.sectionIndexTrackingBackgroundColor
        }
        
        if themeStyles.contains(.separatorStyle) {
            self.separatorStyle = themeStyles.separatorStyle
        }
        
        if themeStyles.contains(.separatorColor) {
            self.separatorColor = themeStyles.separatorColor
        }
                
    }
    
}
