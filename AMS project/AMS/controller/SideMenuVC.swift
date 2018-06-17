//
//  SideMenuVC.swift
//  AMS
//
//  Created by mohamed zead on 3/22/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    //vars
    var options = [ "Home","Notifications","Schedule","Current Attendance","About us " , "Logout" ]
    var optionImage = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "calendar"),#imageLiteral(resourceName: "clipboards (1)"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "logout")]
    //Iboutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
            profileImage.layer.cornerRadius = 70
            profileImage.clipsToBounds = true
            profileImage.layer.borderWidth = 3
            profileImage.layer.borderColor = UIColor.white.cgColor
            tableView.delegate = self
            tableView.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/9.8}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "options")as?OptionCell else{
            return UITableViewCell()
        }
        cell.optionLbl.text = options[indexPath.row]
        cell.optionPhoto.image = optionImage[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            UserDefaults.standard.setValue(false, forKey: "isSignedIn")
            UserDefaults.standard.removeObject(forKey: "stdLevel")
            UserDefaults.standard.removeObject(forKey: "stdName")
            UserDefaults.standard.removeObject(forKey: "stdID")
            UserDefaults.standard.removeObject(forKey: "instID")
            UserDefaults.standard.removeObject(forKey: "instName")




            break
        default: break
            
        }
    }


}
