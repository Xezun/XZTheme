//
//  UIButton+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIButton {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        
        let state = UIControlState.init(themeState)
        switch themeAttribute {
        case .title:            self.setTitle(themeAttributes.title, for: state);
        case .titleColor:       self.setTitleColor(themeAttributes.titleColor, for: state);
        case .titleShadowColor: self.setTitleShadowColor(themeAttributes.titleShadowColor, for: state);
        case .image:            self.setImage(themeAttributes.image, for: state);
        case .backgroundImage:  self.setBackgroundImage(themeAttributes.backgroundImage, for: state);
        case .attributedTitle:  self.setAttributedTitle(themeAttributes.attributedTitle, for: state);
        default:                break;
        }
        
    }
    
}
