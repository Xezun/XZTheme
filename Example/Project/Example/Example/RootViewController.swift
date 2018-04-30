//
//  NextViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return UIRectEdge.all
    }
    
    
    @IBAction func nightAction(_ sender: Any) {
        Theme.night.apply(true)
    }
    
    @IBAction func dayAction(_ sender: Any) {
        Theme.day.apply(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
