//
//  ViewController.swift
//  AMS
//
//  Created by mohamed zead on 2/26/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
class loginVC: UIViewController {
  
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.layer.cornerRadius = 90
        logo.clipsToBounds = true
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.borderWidth = 2.3
        loginBtn.layer.cornerRadius = 32
        loginBtn.clipsToBounds = true
        
    }

}

