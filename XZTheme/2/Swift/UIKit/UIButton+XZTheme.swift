//
//  UIButton+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIButton {
    
    open override func updateAppearance(with themeStyle: Theme.Style) {
        super.updateAppearance(with: themeStyle)
        
        for themeState in themeStyle.themeStates {
            let themeAttributes = themeStyle.themeStyle(forThemeState: themeState)!
            let controlState = UIControlState(themeState)
            for themeAttribute in themeAttributes.themeAttributes {
                switch themeAttribute {
                case .title:            self.setTitle(              themeAttributes.title,            for: controlState);
                case .titleColor:       self.setTitleColor(         themeAttributes.titleColor,       for: controlState);
                case .titleShadowColor: self.setTitleShadowColor(   themeAttributes.titleShadowColor, for: controlState);
                case .image:            self.setImage(              themeAttributes.image,            for: controlState);
                case .backgroundImage:  self.setBackgroundImage(    themeAttributes.backgroundImage,  for: controlState);
                case .attributedTitle:  self.setAttributedTitle(    themeAttributes.attributedTitle,  for: controlState);
                default:                break;
                }
            }
        }
    
        
        
    }
    
}
