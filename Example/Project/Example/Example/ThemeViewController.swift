//
//  ThemeViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/13.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

class ThemeViewController: UITableViewController {
    
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        themeButton.themes.day.normal.setting("icon_theme_night", for: .image)
        themeButton.themes.night.normal.setting("icon_theme_day", for: .image)
        
        themeLabel.themes.day.text              = "It's day now."
        themeLabel.themes.day.backgroundColor   = UIColor(0xf5f5f5ff)
        themeLabel.themes.day.textColor         = UIColor(0x333333ff)
        
        themeLabel.themes.night.text            = "It's night now."
        themeLabel.themes.night.backgroundColor = UIColor(0x252525ff)
        themeLabel.themes.night.textColor       = UIColor(0x707070ff)
        
        self.navigationController?.navigationBar.themes.day
            .setting(UIColor.white, for: .barTintColor)
            .setting(UIColor.black, for: .tintColor)
            .setting(UIImage(filled: 0xccccccFF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
            .setting(UIBarStyle.default, for: .barStyle)
        
        self.navigationController?.navigationBar.themes.night
            .setting(UIColor(0x252525FF), for: .barTintColor)
            .setting(UIColor(0x707070FF), for: .tintColor)
            .setting(UIImage(filled: 0x555555FF, size: CGSize(width: 0.5, height: 0.5)), for: .shadowImage)
            .setting(UIBarStyle.black, for: .barStyle)
        
        view.themes.day.backgroundColor = UIColor.white
        view.themes.night.backgroundColor = UIColor(0x303030ff)

        let label = XZLabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        label.text = "This is a label."
        label.backgroundColor = UIColor.lightGray
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false;
        let lc1 = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let lc2 = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(lc1)
        view.addConstraint(lc2)


        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func themeButtonAction(_ switch: UIButton) {
        switch Theme.current {
        case .day: Theme.night.apply(animated: true)
        case .night: Theme.day.apply(animated: true)
        default:
            fatalError("Not Supported Theme")
        }
    }
    
    
}




@IBDesignable

open class XZLabel: UILabel {
    
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







