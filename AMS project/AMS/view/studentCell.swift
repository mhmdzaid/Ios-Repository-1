//
//  studentCell.swift
//  AMS
//
//  Created by mohamed zead on 3/18/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class StudentCell : UITableViewCell {
    
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    @IBAction func pauseBtn(_ sender: Any) {
        checkImg.image = UIImage()
    }
    @IBAction func startBtn(_ sender: Any) {
        checkImg.image = UIImage(named: "pls")
    }
}
