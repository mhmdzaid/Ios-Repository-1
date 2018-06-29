//
//  HomeVC.swift
//  AMS
//
//  Created by mohamed zead on 3/22/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
public static var sideMenuVisible = false
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var currentAttendanceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
     scheduleButton.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
     scheduleButton.layer.borderWidth = 1.2
     logoutButton.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
     logoutButton.layer.borderWidth = 1.2
     notificationButton.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
     notificationButton.layer.borderWidth = 1.2
     aboutUsButton.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
     aboutUsButton.layer.borderWidth = 1.2
     currentAttendanceButton.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
     currentAttendanceButton.layer.borderWidth = 1.2
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
        let SCHEDuleVC = TabBarVC.viewControllers![1] as! scheduleVC
        TabBarVC.selectedViewController = SCHEDuleVC
    }
    @IBAction func logoutPressed(_ sender: Any) {
            UserDefaults.standard.setValue(false, forKey: "isSignedIn")
            UserDefaults.standard.removeObject(forKey: "instID")
            UserDefaults.standard.removeObject(forKey: "instName")
            UserDefaults.standard.removeObject(forKey: "role")
            UserDefaults.standard.setValue(false, forKey: "isSignedIn")
            UserDefaults.standard.removeObject(forKey: "stdLevel")
            UserDefaults.standard.removeObject(forKey: "stdName")
            UserDefaults.standard.removeObject(forKey: "stdID")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyBoard.instantiateViewController(withIdentifier: "startVC")
            
            self.present(startVC, animated: true, completion: nil)
        
    }
    @IBAction func notificationPressed(_ sender: Any) {
        let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
        let NotifVC = TabBarVC.viewControllers![2] as! NotificationVC
        TabBarVC.selectedViewController = NotifVC
    }
    
    @IBAction func AboutUsPressed(_ sender: Any) {
        let sideMenuVC = self.revealViewController().rearViewController as! SideMenuVC
        self.revealViewController().revealToggle(self)
        sideMenuVC.performSegue(withIdentifier: "aboutUS", sender: nil)
        
    }
    @IBAction func currentAttenPressed(_ sender: Any) {
        let sideMenuVC = self.revealViewController().rearViewController as! SideMenuVC
        self.revealViewController().revealToggle(self)
        sideMenuVC.performSegue(withIdentifier: "manualAttend", sender: nil)
    }
    @IBAction func menuBtnSelected(_ sender: Any) {
        if HomeVC.sideMenuVisible == true{
            HomeVC.sideMenuVisible = false
            self.view.alpha = 1
        }
        else{
            HomeVC.sideMenuVisible = true
            self.view.alpha = 0.85
        }
    }
    
}
