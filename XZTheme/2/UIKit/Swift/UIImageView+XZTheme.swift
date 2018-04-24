//
//  UIImageView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIImageView {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.Styles) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            switch themeAttribute {
            case .image:                        self.image              = themeStyles.image;
            case .highlightedImage:             self.highlightedImage   = themeStyles.highlightedImage;
            case .isHighlighted:                self.isHighlighted      = themeStyles.isHighlighted;
            case .animationImages:              self.animationImages    = themeStyles.animationImages;
            case .highlightedAnimationImages:   self.highlightedAnimationImages = themeStyles.highlightedAnimationImages;
            case .isAnimating:                  if themeStyles.isAnimating { self.startAnimating(); } else { self.stopAnimating(); }
            default:                            break;
            }
        }
        
    }

}
