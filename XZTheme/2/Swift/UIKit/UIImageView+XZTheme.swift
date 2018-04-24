//
//  UIImageView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIImageView {
    
    open override func updateAppearance(with themeStyle: Theme.Style) {
        super.updateAppearance(with: themeStyle)
        
        for themeAttribute in themeStyle.themeAttributes {
            switch themeAttribute {
            case .image:                        self.image              = themeStyle.image;
            case .highlightedImage:             self.highlightedImage   = themeStyle.highlightedImage;
            case .isHighlighted:                self.isHighlighted      = themeStyle.isHighlighted;
            case .animationImages:              self.animationImages    = themeStyle.animationImages;
            case .highlightedAnimationImages:   self.highlightedAnimationImages = themeStyle.highlightedAnimationImages;
            case .isAnimating:                  if themeStyle.isAnimating { self.startAnimating(); } else { self.stopAnimating(); }
            default:                            break;
            }
        }
        
    }

}
