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
        tableView.dataSource = self 
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell") as? NotificationCell
        else{
            return UITableViewCell()
        }
        cell.layer.borderWidth = 1.3
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
