//
//  studentCell.swift
//  AMS
//
//  Created by mohamed zead on 3/18/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Alamofire

class StudentCell : UITableViewCell {
    var timer : Timer!
    var minute : Int = 0
    var seconds : Int = 0
    var timerValue = 300
    var id = 0 
    var delegate : StudentCellDelegate?
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var studentName: UILabel!
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var studentSwitch: UISwitch!
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBAction func pausePressed(_ sender: Any) {
       
        print("_____________\(self.studentName.text)__________")
        self.delegate?.pauseButtonPressed(cellResume: vieww)
        timer  = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
        timer.fire()


        
    }
    
    @IBAction func resumePressed(_ sender: Any) {
     timer.invalidate()
     self.delegate?.resumeButtonPressed( cellResume: vieww)
    }
    
    
    
    @objc func startTime(){
        
            timerValue-=1
            minute = timerValue/60
            seconds = timerValue % 60
            if self.seconds<10{
                self.timeLabel.text = "\(self.minute):0\(self.seconds)"
            }else{self.timeLabel.text = "\(self.minute):\(self.seconds)"}
        
        if minute == 0 && seconds == 0 {
            self.timer.invalidate()
           // self.isUserInteractionEnabled = false
            let headers  =  ["content-type" : "application/json"]
            let url = "http://syntax-eg.esy.es/api/students_in_Location/"+String(self.id)
            Alamofire.request(url, method: .delete, parameters: nil, encoding:JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                
            })
        }
        
    }

    
}
protocol StudentCellDelegate {
    func pauseButtonPressed(cellResume:UIView)
    func resumeButtonPressed(cellResume:UIView)
}

//
//
//print("pause tapped")
//self.vieww.isHidden = false
