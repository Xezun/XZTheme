//
//  Theme+UILabel.swift
//  Example
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style where ObjectType == UILabel {
    
    public var textColor: UIColor? {
        get { return color(forThemeAttribute: .backgroundColor) }
        set { setValue(newValue, forThemeAttribute: .backgroundColor) }
    }
    
}


extension UILabel {
    
    @objc public func updateAppearance(with themeStyles: Theme.StyleCollection<UIView>) {
        
    }
    
    
}
