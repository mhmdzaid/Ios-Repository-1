//
//  NotificationVC.swift
//  AMS
//
//  Created by mohamed zead on 3/22/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    public static var sideMenuVisible = false
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        tableView.delegate = self
        
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        if NotificationVC.sideMenuVisible == true{
            NotificationVC.sideMenuVisible = false
            self.view.alpha = 1
        }
        else{
            NotificationVC.sideMenuVisible = true
            self.view.alpha = 0.85
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell") as? NotificationCell
        else{
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
