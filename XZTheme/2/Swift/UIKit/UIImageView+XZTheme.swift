//
//  UIImageView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIImageView {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        switch themeAttribute {
        case .image:                        self.image = themeAttributes.image;
        case .highlightedImage:             self.highlightedImage = themeAttributes.highlightedImage;
        case .isHighlighted:                self.isHighlighted = themeAttributes.isHighlighted;
        case .animationImages:              self.animationImages = themeAttributes.animationImages;
        case .highlightedAnimationImages:   self.highlightedAnimationImages = themeAttributes.highlightedAnimationImages;
        case .isAnimating:                  if themeAttributes.isAnimating { self.startAnimating(); } else { self.stopAnimating(); }
        default:                            break;
        }
        
    }

}
