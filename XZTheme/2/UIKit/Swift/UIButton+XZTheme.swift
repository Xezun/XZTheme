//
//  UIButton+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIButton {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.Styles) {
        super.updateAppearance(with: themeStyles)
        
        for themeState in themeStyles.themeStates {
            let themeStyle      = themeStyles.themeStyle(forThemeState: themeState)!
            let controlState    = UIControlState(themeState)
            for themeAttribute in themeStyle.themeAttributes {
                switch themeAttribute {
                case .title:            self.setTitle(              themeStyle.title,            for: controlState);
                case .titleColor:       self.setTitleColor(         themeStyle.titleColor,       for: controlState);
                case .titleShadowColor: self.setTitleShadowColor(   themeStyle.titleShadowColor, for: controlState);
                case .image:            self.setImage(              themeStyle.image,            for: controlState);
                case .backgroundImage:  self.setBackgroundImage(    themeStyle.backgroundImage,  for: controlState);
                case .attributedTitle:  self.setAttributedTitle(    themeStyle.attributedTitle,  for: controlState);
                default:                break;
                }
            }
        }
    }
    
}
