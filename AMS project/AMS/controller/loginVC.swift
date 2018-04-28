//
//  ViewController.swift
//  AMS
//
//  Created by mohamed zead on 2/26/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class loginVC: UIViewController {
  
   
    var loginType : loginType = .student
    var student_id = 0
    var instructor_id = 0
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
   
    @IBAction func loginPressed(_ sender: Any) {
        let ScheduleVC = storyboard?.instantiateViewController(withIdentifier: "scheduleVC")as! scheduleVC

        if loginType == .student
        {
            Alamofire.request("http://syntax-eg.esy.es/api/students").responseJSON { (Response) in
            if  let response = Response.result.value{
              print(Response)
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
                    let all = students["all_Students"].arrayValue
                    for std in all
                    {
                        if std["username"].stringValue == student
                        {   self.student_id = std["id"].intValue
                            ScheduleVC.studentID = self.student_id
                            ScheduleVC.loginType = .student
                            let url = "http://syntax-eg.esy.es/api/studentLogin"
                           
                         
                            let params : [String : String] = ["username":"\(std["username"].stringValue)","password":"\(password!)"]
                             let header = ["content-type" : "application/json"]

                            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (Response) in
                                let response = JSON(Response.result.value!)
                                let status = response["status"].stringValue
                                
                                if status == "you don't have an account" {
                                    let alert =  UIAlertController(title: "LOGIN ERROR ", message: status, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                                        alert.dismiss(animated: true, completion: nil)
                                        self.username.text = ""
                                        self.password.text = ""
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
                        let all = instructors["all_Instructors"].arrayValue
                        for inst in all
                        {
                            if inst["username"].stringValue == instructor
                            {
                                self.instructor_id = inst["id"].intValue
                                ScheduleVC.instructorID = self.instructor_id
                                ScheduleVC.loginType = .instructor
                                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                
                            }else{
                                let alert =  UIAlertController(title: "LOGIN ERROR ", message: "username not found ", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.destructive, handler: { (Action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                 self.present(alert, animated: true, completion: nil)
                                self.username.text = ""
                                self.password.text = ""
                                
                            }
                        }
                    }
                    
                    
                }else{
                    print("error getting data ")
                }
            }
            
        }
        navigationController?.pushViewController(ScheduleVC, animated: true)
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

}
enum loginType {
    
    case student
    case instructor
}

