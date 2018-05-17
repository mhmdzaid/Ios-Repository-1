//
//  ViewController.swift
//  AMS
//
//  Created by mohamed zead on 2/26/18.
//  Copyright © 2018 zead. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration.CaptiveNetwork





class loginVC: UIViewController {
   var found = false
    var loginType : loginType?
    var student_id = 0
    var instructor_id = 0
    var studentLevel : String?
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
   
    @IBAction func loginPressed(_ sender: Any) {
        if checkLocation() == true{
        
            
        let ScheduleVC = storyboard?.instantiateViewController(withIdentifier: "scheduleVC")as! scheduleVC

        if loginType == .student
        {
           
            Alamofire.request("http://syntax-eg.esy.es/api/students").responseJSON { (Response) in
            if  let response = Response.result.value{
              
              let students = JSON(response)
                if (self.username.text?.isEmpty)! || (self.password.text?.isEmpty)!{
                   let alert =  UIAlertController(title: "LOGIN ERROR ", message: "please fill  the fields", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                   let student = self.username.text
                   let password = self.password.text
                    print(student!)
                    print(password!)
                    let all = students["student"].arrayValue
                    
                    for std in all
                    {
                        if std["username"].stringValue == student
                        {
                            self.found = true
                            self.student_id = std["id"].intValue
                            ScheduleVC.studentID = self.student_id
                            ScheduleVC.loginType = .student
                            let url = "http://syntax-eg.esy.es/api/studentLogin"
                            self.studentLevel = std["level"].stringValue
                          
                            let params : [String : String] = ["username":"\(std["username"].stringValue)","password":"\(password!)"]
                             let header = ["content-type" : "application/json"]
                            let paramsForPost = ["id":"\(std["id"].intValue)","name":"\(std["name"].stringValue)"]
                            Alamofire.request("http://syntax-eg.esy.es/api/students_in_Location", method: .post, parameters: paramsForPost, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (Response) in
                                
                            })
                            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (Response) in
                                let response = JSON(Response.result.value!)
                                let status = response["studentLogin"].stringValue
                                print("===============>>>\(status)")
                                if status == "you don't have an account" {
                                    let alert =  UIAlertController(title: "LOGIN ERROR ", message: "wrong password ", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                                        alert.dismiss(animated: true, completion: nil)
                                        self.username.text = ""
                                        self.password.text = ""
                                        self.found = false
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }else{
                                    
                                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                }
                                //print("-----------------------------------\(String(describing: Response.result.value))")
                            })
                           break
                        }
                    }
                    if self.found != true {
                    let alert2 =  UIAlertController(title: "LOGIN ERROR ", message: "wrong username ", preferredStyle: UIAlertControllerStyle.alert)
                    alert2.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                        alert2.dismiss(animated: true, completion: nil)
                        self.username.text = ""
                        self.password.text = ""
                    }))
                    self.present(alert2, animated: true, completion: nil)
                
                    }
                    
                }
                
        
            }else{
                print("error getting data ***** ")
            }
        }
        
    }
        else{

            Alamofire.request("http://syntax-eg.esy.es/api/instructors").responseJSON { (Response) in
                if  let response = Response.result.value{
                    
                    let instructors = JSON(response)
                    if (self.username.text?.isEmpty)! || (self.password.text?.isEmpty)!{
                        let alert =  UIAlertController(title: "LOGIN ERROR ", message: "please fill the fields", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        
                        let instructor = self.username.text
                        let password = self.password.text
                        let all = instructors["instructor"].arrayValue
                        for inst in all
                        {
                            if inst["username"].stringValue == instructor
                            {
                                self.found = true
                                self.instructor_id = inst["id"].intValue
                                ScheduleVC.instructorID = self.instructor_id
                                ScheduleVC.loginType = .instructor
                                let url  = "http://syntax-eg.esy.es/api/instructorLogin"
                                
                                
                                let params : [String : String] = ["username":"\(inst["username"].stringValue)","password":"\(password!)"]
                                let header = ["content-type" : "application/json"]
                                
                                Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (Response) in
                                    let response = JSON(Response.result.value!)
                                    let status = response["status"].stringValue
                                    
                                    if status == "you don't have an account" {
                                        let alert =  UIAlertController(title: "LOGIN ERROR ", message: "wrong password", preferredStyle: UIAlertControllerStyle.alert)
                                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                                            alert.dismiss(animated: true, completion: nil)
                                            self.username.text = ""
                                            self.password.text = ""
                                            self.found = false
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                    }else{
                                        
                                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                        
                                    }
                                    
                                    print("-----------------------------------\(String(describing: Response.result.value))")
                                })
                                
                                break
                            }
                            
                        }
                        if self.found != true{
                            let alert2 =  UIAlertController(title: "LOGIN ERROR ", message: "wrong username ", preferredStyle: UIAlertControllerStyle.alert)
                            alert2.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                                alert2.dismiss(animated: true, completion: nil)
                                self.username.text = ""
                                self.password.text = ""
                            }))
                            self.present(alert2, animated: true, completion: nil)
                            
                        }
                    }
                    
                    
                }else{
                    print("error getting data ")
                }
            }
            
        }
        navigationController?.pushViewController(ScheduleVC, animated: true)
        }else{
            let alert =  UIAlertController(title: "LOGIN ERROR ", message: " you are home or someWhere 😃 ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                alert.dismiss(animated: true, completion: nil)
                self.username.text = ""
                self.password.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue"{
            let swreveal = segue.destination as! SWRevealViewController
            if loginType == .student{
            swreveal.loginType = 0
                swreveal.studentLevel = Int32(self.studentLevel!)!
            }else{
                swreveal.loginType = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.cornerRadius = 90
        logo.clipsToBounds = true
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.borderWidth = 2.3
        loginBtn.layer.cornerRadius = 32
        loginBtn.clipsToBounds = true
        print(self.loginType)
    }

    func checkLocation()->Bool{
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        print("the ssid is =========>>>>>>>>>>>\(String(describing: ssid))")
        ssid = "_BUG_"
        if ssid == "_BUG_"
        {
            return true
        }
        else{return false}
    }
}
enum loginType {
    
    case student
    case instructor
}

