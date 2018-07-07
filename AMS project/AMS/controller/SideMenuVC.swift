//
//  SideMenuVC.swift
//  AMS
//
//  Created by mohamed zead on 3/22/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SideMenuVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    //vars
    var groupNumber = UserDefaults.standard.string(forKey: "role")
    var loginType   = UserDefaults.standard.integer(forKey: "loginType")
    var studentLevel = UserDefaults.standard.string(forKey: "studentLevel")
    var options = [ "Home","Notifications","Schedule","Current Attendance","About us " , "Logout" ]
    var optionImage = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "calendar"),#imageLiteral(resourceName: "clipboards (1)"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "logout")]
    //Iboutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        NotificationVC.sideMenuVisible = true
        HomeVC.sideMenuVisible = true
        scheduleVC.sideMenuVisible = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
            profileImage.layer.cornerRadius = 70
            profileImage.clipsToBounds = true
            profileImage.layer.borderWidth = 3
            profileImage.layer.borderColor = UIColor.white.cgColor
        
        if loginType == 0{
            options = [ "Home","Notifications","Schedule","About us " , "Logout" ]
            
            self.userName.text = UserDefaults.standard.string(forKey: "stdName")
        }else{
            self.userName.text = UserDefaults.standard.string(forKey: "instName")
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
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
        case 0 :
            self.revealViewController().revealToggle(self)
            let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
            let HomeVC = TabBarVC.viewControllers![0] as! HomeVC
            TabBarVC.selectedViewController = HomeVC
            break
        case 1:
            self.revealViewController().revealToggle(self)
            let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
            let NotificationVC = TabBarVC.viewControllers![2] as! NotificationVC
            TabBarVC.selectedViewController = NotificationVC
            break
        case 2:
            self.revealViewController().revealToggle(self)
            let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
            let SCHEDuleVC = TabBarVC.viewControllers![1] as! scheduleVC
            TabBarVC.selectedViewController = SCHEDuleVC
            break
        case 3:
           if loginType != 0{
            
            self.revealViewController().revealToggle(self)
            let TabBarVC = self.revealViewController().frontViewController as! UITabBarController
            let SCHEDuleVC = TabBarVC.viewControllers![1] as! scheduleVC
            TabBarVC.selectedViewController = SCHEDuleVC
            SCHEDuleVC.instructorView.isHidden = false
            Alamofire.request("http://syntax-eg.esy.es/api/students_in_Location/groupNumber/\(self.groupNumber!)").responseJSON(completionHandler: { (response) in
                print("here is the groupNumber = \(self.groupNumber!)")
                let Response =  response.result.value
                let allData = JSON(Response)
                let students = allData["data"].arrayValue
                 SCHEDuleVC.studentNumber.text = String(students.count)
            })
           }else{
            self.performSegue(withIdentifier: "aboutUS", sender: nil)
           }
            break
        case 4:
            if loginType == 0{
            UserDefaults.standard.setValue(false, forKey: "isSignedIn")
            UserDefaults.standard.removeObject(forKey: "stdLevel")
            UserDefaults.standard.removeObject(forKey: "stdName")
            UserDefaults.standard.removeObject(forKey: "stdID")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyBoard.instantiateViewController(withIdentifier: "startVC")
            
            self.present(startVC, animated: true, completion: nil)
            }
            else{
                self.performSegue(withIdentifier: "aboutUS", sender: nil)
            }
            break
        case 5:
            UserDefaults.standard.setValue(false, forKey: "isSignedIn")
            UserDefaults.standard.removeObject(forKey: "instID")
            UserDefaults.standard.removeObject(forKey: "instName")
            UserDefaults.standard.removeObject(forKey: "role")
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let startVC = storyBoard.instantiateViewController(withIdentifier: "startVC")
            
         self.present(startVC, animated: true, completion: nil)
         
        break
        default: break
            
        }
    }


}
