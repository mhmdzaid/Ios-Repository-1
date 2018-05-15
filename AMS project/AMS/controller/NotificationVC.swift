//
//  NotificationVC.swift
//  AMS
//
//  Created by mohamed zead on 3/22/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    var sideMenuVisible = false
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        if sideMenuVisible == true{
            sideMenuVisible = false
            self.view.alpha = 1
        }
        else{
            sideMenuVisible = true
            self.view.alpha = 0.85
        }
    }
    
}
