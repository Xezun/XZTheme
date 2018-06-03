//
//  ThemeApplyViewController.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZTheme

class ThemeApplyViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if indexPath.row == 0 {
            cell.imageView?.themes.day.image = UIImage(named: "icon_sun_day")
            cell.imageView?.themes.night.image = UIImage(named: "icon_sun_night")
            if Theme.current == .day {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        } else {
            cell.imageView?.themes.day.image = UIImage(named: "icon_moon_day")
            cell.imageView?.themes.night.image = UIImage(named: "icon_moon_night")
            if Theme.current == .night {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Theme.day.apply(animated: true)
        } else {
            Theme.night.apply(animated: true)
        }
        tableView.reloadData()
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
