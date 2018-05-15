//
//  studentCell.swift
//  AMS
//
//  Created by mohamed zead on 3/18/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class StudentCell : UITableViewCell {
    var timer : Timer!
    var minute : Int!
    var seconds : Int!
    var delegate : StudentCellDelegate?
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var viewPP: UIView!
    @IBOutlet weak var studentName: UILabel!
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var studentSwitch: UISwitch!
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBAction func pausePressed(_ sender: Any) {
       print("hello world ")
        self.delegate?.pauseButtonPressed(cellResume: vieww)
        
    }
    
    @IBAction func resumePressed(_ sender: Any) {
        print("you welcome ")
        self.delegate?.resumeButtonPressed( cellResume: vieww)
    }
    
}
protocol StudentCellDelegate {
    func pauseButtonPressed(cellResume:UIView)
    func resumeButtonPressed(cellResume:UIView)
}
//
//@objc func startTime(){
//    while (self.timeLabel.text != "0:00"){
//        self.minute = Int(timer.timeInterval/60)
//        self.seconds = Int(timer.timeInterval) % 60
//        if self.seconds<10{
//            self.timeLabel.text = "\(self.minute):0\(self.seconds)"
//        }else{self.timeLabel.text = "\(self.minute):\(self.seconds)"}
//    }
//
//}

//
//
//print("pause tapped")
//self.vieww.isHidden = false
//timer  = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(startTime), userInfo: nil, repeats: false)
//timer.fire()

