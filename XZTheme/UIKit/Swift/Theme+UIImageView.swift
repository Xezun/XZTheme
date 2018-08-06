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
        get { return image(for: .image)  }
        set { setValue(newValue, for: .image)  }
    }
    
    public var highlightedImage: UIImage? {
        get { return image(for: .highlightedImage)       }
        set { setValue(newValue, for: .highlightedImage) }
    }
    
    public var images: [UIImage]? {
        get { return images(for: .images)         }
        set { setValue(newValue, for: .images)    }
    }
    
    public var animationImages: [UIImage]? {
        get { return image(for: .animationImages)?.images }
        set { setValue(newValue, for: .animationImages)   }
    }
    
    public var highlightedAnimationImages: [UIImage]? {
        get { return image(for: .highlightedAnimationImages)?.images }
        set { setValue(newValue, for: .highlightedAnimationImages)   }
    }
    
    public var isAnimating: Bool {
        get { return boolValue(for: .isAnimating)   }
        set { setValue(newValue, for: .isAnimating) }
    }
    
    public var isHighlighted: Bool {
        get { return boolValue(for: .isHighlighted)   }
        set { setValue(newValue, for: .isHighlighted) }
    }
    
    /// 该属性对应的主题属性为 `.placeholder` 。
    public var placeholderImage: UIImage? {
        get { return image(for: .placeholder)  }
        set { setValue(newValue, for: .placeholder)  }
    }
    
}

extension UIImageView {
    
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.image) {
            self.image = themeStyles.image
        }
        
        if themeStyles.contains(.highlightedImage) {
            self.highlightedImage   = themeStyles.highlightedImage
        }
        
        if themeStyles.contains(.animationImages) {
            self.animationImages    = themeStyles.animationImages
        }
        
        if themeStyles.contains(.highlightedAnimationImages) {
            self.highlightedAnimationImages = themeStyles.highlightedAnimationImages
        }
        
        if themeStyles.contains(.isHighlighted) {
            self.isHighlighted      = themeStyles.isHighlighted
        }
        
        if themeStyles.contains(.isAnimating) {
            if themeStyles.isAnimating {
                self.startAnimating()
            } else {
                self.stopAnimating();
            }
        }
        
        if themeStyles.contains(.placeholder) {
            self.placeholder = themeStyles.placeholderImage
        }
    }
    
}
