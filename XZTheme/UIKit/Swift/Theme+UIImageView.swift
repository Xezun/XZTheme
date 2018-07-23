//
//  Theme+UIImageView.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIImageView.image
    public static let image                         = Theme.Attribute.init(rawValue: "image");
    /// UIImageView.highlightedImage
    public static let highlightedImage              = Theme.Attribute.init(rawValue: "highlightedImage")
    /// UIImageView.images
    public static let images                        = Theme.Attribute.init(rawValue: "images")
    /// UIImageView.animationImages
    public static let animationImages               = Theme.Attribute.init(rawValue: "animationImages")
    /// UIImageView.highlightedAnimationImages
    public static let highlightedAnimationImages    = Theme.Attribute.init(rawValue: "highlightedAnimationImages")
    /// UIImageView.isAnimating, UIActivityIndicatorView.isAnimating
    public static let isAnimating                   = Theme.Attribute.init(rawValue: "isAnimating")
    /// UIImageView.isHighlighted
    public static let isHighlighted                 = Theme.Attribute.init(rawValue: "isHighlighted")
    /// For UIImageView, UITextField, UISearchBar
    public static let placeholder                   = Theme.Attribute.init(rawValue: "placeholder")
}

extension Theme.Style {
    
    public var image: UIImage? {
        get { return image(forThemeAttribute: .image)  }
        set { setValue(newValue, forThemeAttribute: .image)  }
    }
    
    public var highlightedImage: UIImage? {
        get { return image(forThemeAttribute: .highlightedImage)       }
        set { setValue(newValue, forThemeAttribute: .highlightedImage) }
    }
    
    public var images: [UIImage]? {
        get { return images(forThemeAttribute: .images)         }
        set { setValue(newValue, forThemeAttribute: .images)    }
    }
    
    public var animationImages: [UIImage]? {
        get { return image(forThemeAttribute: .animationImages)?.images }
        set { setValue(newValue, forThemeAttribute: .animationImages)   }
    }
    
    public var highlightedAnimationImages: [UIImage]? {
        get { return image(forThemeAttribute: .highlightedAnimationImages)?.images }
        set { setValue(newValue, forThemeAttribute: .highlightedAnimationImages)   }
    }
    
    public var isAnimating: Bool {
        get { return boolValue(forThemeAttribute: .isAnimating)   }
        set { setValue(newValue, forThemeAttribute: .isAnimating) }
    }
    
    public var isHighlighted: Bool {
        get { return boolValue(forThemeAttribute: .isHighlighted)   }
        set { setValue(newValue, forThemeAttribute: .isHighlighted) }
    }
    
    /// 该属性对应的主题属性为 `.placeholder` 。
    public var placeholderImage: UIImage? {
        get { return image(forThemeAttribute: .placeholder)  }
        set { setValue(newValue, forThemeAttribute: .placeholder)  }
    }
    
}

extension UIImageView {
    
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.image) {
            self.image = themeStyles.image
        }
        
        if themeStyles.containsThemeAttribute(.highlightedImage) {
            self.highlightedImage   = themeStyles.highlightedImage
        }
        
        if themeStyles.containsThemeAttribute(.animationImages) {
            self.animationImages    = themeStyles.animationImages
        }
        
        if themeStyles.containsThemeAttribute(.highlightedAnimationImages) {
            self.highlightedAnimationImages = themeStyles.highlightedAnimationImages
        }
        
        if themeStyles.containsThemeAttribute(.isHighlighted) {
            self.isHighlighted      = themeStyles.isHighlighted
        }
        
        if themeStyles.containsThemeAttribute(.isAnimating) {
            if themeStyles.isAnimating {
                self.startAnimating()
            } else {
                self.stopAnimating();
            }
        }
        
        if themeStyles.containsThemeAttribute(.placeholder) {
            self.placeholder = themeStyles.placeholderImage
        }
    }
    
}
