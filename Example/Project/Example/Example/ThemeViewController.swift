//
//  ThemeViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/13.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}

extension Theme.Collection {

    var day: Theme.Style.Collection {
        return self.themeStyles(forTheme: .day)
    }

    var night: Theme.Style.Collection {
        return self.themeStyles(forTheme: .night)
    }

}

class ThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.themes.day.backgroundColor    = UIColor.white
        view.themes.night.backgroundColor  = UIColor(0x303030ff)

        let label = OMLabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        label.text = "This is a label."
        label.backgroundColor = UIColor.lightGray
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false;
        let lc1 = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let lc2 = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(lc1)
        view.addConstraint(lc2)

        label.themes.day.text              = "It's day now."
        label.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
        label.themes.day.textColor         = UIColor(0x333333ff)

        label.themes.night.text            = "It's night now."
        label.themes.night.backgroundColor = UIColor(0x252525ff)
        label.themes.night.textColor       = UIColor(0x707070ff)


        let button = UIButton(type: .system)

        button.frame = CGRect.init(x: 100, y: 100, width: 150, height: 40)

        button.themes.day.setThemeStyles(byUsing: [
            .normal: [
                .title: "Day normal",
                .titleColor: 0x0000FFFF,
                .backgroundImage: UIImage(filled: 0xCCCCCCFF)
            ],
            .highlighted: [
                .title: "Day highlighted",
                .titleColor: 0x9999FFFF,
                .backgroundImage: UIImage(filled: 0xDDDDDDFF)
            ]
        ])
        
        button.themes.night.setThemeStyles(byUsing: [
            .normal: [
                .title: "Night normal",
                .titleColor: 0x008800FF,
                .backgroundImage: UIImage(filled: 0x555555ff)
            ],
            .highlighted: [
                .title: "Night highlighted",
                .titleColor: 0x007700FF,
                .backgroundImage: UIImage(filled: 0x444444FF)
            ]
        ])

        view.addSubview(button)
        
        let cell: UITableViewCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




@IBDesignable open class OMLabel: UILabel {
    
    @IBInspectable open var contentInsets: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    
    override open func drawText(in rect: CGRect) {
        let textRect = UIEdgeInsetsInsetRect(rect, contentInsets)
        super.drawText(in: textRect)
    }
    
    override open var intrinsicContentSize: CGSize {
        let size1 = super.intrinsicContentSize
        return CGSize.init(
            width: size1.width + contentInsets.left + contentInsets.right,
            height: size1.height + contentInsets.top + contentInsets.bottom
        )
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let size1 = super.sizeThatFits(size)
        return CGSize.init(
            width: size1.width + contentInsets.left + contentInsets.right,
            height: size1.height + contentInsets.top + contentInsets.bottom
        )
    }
    
}
