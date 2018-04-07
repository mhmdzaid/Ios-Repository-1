//
//  scheduleVC.swift
//  AMS
//
//  Created by mohamed zead on 2/28/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class scheduleVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    //lectures and sections data
    var i = 0
   var questions = ["is there interaction in the lecture?","what is your satisfation of reply of misunderstanding questions?","does instructor have all lecture time? ","what about studying resources of this course?","what about instructor latency ?"]
    var choices  = [String](repeating:"", count: 5)
    var choice = ""
    var subject = [
        
        ExpandableNames(isExpanded: true, subjects: ["subject":"computer vision","time" : "10:12 AM","type" : "section" ]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"Neural network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:   ["subject":"image processing","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"operating system","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"Network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects: ["subject":"Network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects: ["subject":"algorithm","time" : "2:00","type" : "lecture"])]
    
    let days  = ["  saturday","  sunday","  monday","  tuseday","  wednisday ","  thursday"]
    let minus =  UIImage(named: "Shape 1")
    let plus = UIImage(named: "pls")
    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var thankingView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var profImageInfo: UIImageView!
    @IBOutlet weak var professorImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var subjectInfo: UILabel!
    @IBOutlet weak var professorNameInfo: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var marks: UILabel!
    @IBOutlet weak var attendanceLocation: UILabel!
    //instructor View outlets
    @IBOutlet weak var instructorView: UIView!
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var startedAt: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var studentNumber: UILabel!
    //iboutlets of step bar
    
    @IBOutlet weak var c0: UIImageView!
    @IBOutlet weak var c1: UIImageView!
    @IBOutlet weak var c2: UIImageView!
    @IBOutlet weak var c3: UIImageView!
    @IBOutlet weak var c4: UIImageView!


    @IBAction func passwordOkpressed(_ sender: Any) {
        passwordView.isHidden = true
    }
    @IBAction func DissmissBtn(_ sender: Any) {
        thankingView.isHidden = true
    }
    @IBAction func okPressed(_ sender: Any) {
        infoView.isHidden = true
       tableView.alpha = 1
        
    }
    @IBAction func choiceSelected(_ sender: DLRadioButton) {
       let tag = sender.tag
        
        switch tag {
        case -1:
            choice = "Very satisfied"
            break
        case -2 :
            choice = "Satisfied"
            break
        case -3 :
            choice = "Not bad"
            break
        case -4 :
            choice = "Unsatisfied"
            break
        case -5 :
            choice = "Very unsatisfied"
            break
        default:
            print("wrong coding ")
        }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if i>0
        {
            if i == 5
            {
                let circle =  feedbackView.viewWithTag(i-1)as? UIImageView
                circle?.image = UIImage(named: "ccover")
                i-=1
                question.text = questions[i]
            }
            let circle =  feedbackView.viewWithTag(i)as? UIImageView
            circle?.image = UIImage(named: "ccover")
            i-=1
            question.text = questions[i]
            
        }
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        print("------------------------\(choice)")
        choices[i] = choice
    
        if i<5
        {
            
            if i == 4
            {
            question.text = questions[i]
            i+=1
            if i == 5
            {
                thankingView.isHidden = false
                feedbackView.isHidden = true
            }
            
            print("---------------------\(choices)")
            return
            }
            i+=1
            question.text = questions[i]
            let circle =  feedbackView.viewWithTag(i)as? UIImageView
            circle?.image = UIImage(named: "circle")
        }
        if i == 5
        {
        thankingView.isHidden = false
        feedbackView.isHidden = true
        
       
        
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        self.layoutConfig()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }

    func layoutConfig()->(){
        infoView.isHidden = true
        profImageInfo.layer.cornerRadius = 25
        profImageInfo.clipsToBounds = true
        profImageInfo.backgroundColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        thankingView.isHidden = true
        thankingView.layer.borderColor = UIColor.black.cgColor
        thankingView.layer.borderWidth = 0.3
        passwordView.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.borderWidth = 0.3
      //  passwordView.isHidden = true
        passField.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        passField.layer.borderWidth = 1
        passField.layer.cornerRadius = 10
        ok.layer.cornerRadius = 8
        question.text = questions[i]
        feedbackView.layer.borderWidth = 0.7
        feedbackView.layer.borderColor = UIColor.black.cgColor
        backBtn.layer.borderWidth = 1.3
        backBtn.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        
    }
    
   
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"cell" ) as? scheduleCellTableViewCell else{
            return UITableViewCell()
        }
        cell.ProfImage.layer.cornerRadius = 33
        cell.ProfImage.clipsToBounds = true
        cell.ProfImage.backgroundColor = UIColor.white
        cell.timeLbl.text = subject[indexPath.row].subjects["time"]
        cell.subjectLbl.text = subject[indexPath.row].subjects["subject"]
        cell.TypeLbl.text = subject[indexPath.row].subjects["type"]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !subject[section].isExpanded{
            
            return 0
        }
        return subject[section].subjects.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        infoView.isHidden = false
        thankingView.isHidden = true
        subjectInfo.text = subject[indexPath.row].subjects["subject"]
        startTime.text = subject[indexPath.row].subjects["time"]
         tableView.alpha = 0.4
      
    }
    
    
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
      // button.imageRect(forContentRect: CGRect(x: 30, y: 20, width:10, height:10))
        
        button.setTitle(days[section], for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.textAlignment = NSTextAlignment.left
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(expandCollapse(button:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.tag = section
        button.setImage(minus, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        
        if subject[section].isExpanded{
            button.setImage(minus, for: .normal)
            button.imageView?.image = minus
        }else{
            
            button.setImage(plus, for: .normal)
            
        }
        return button
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100    }
    
    @objc func expandCollapse(button:UIButton){
        thankingView.isHidden = true
        print(button.tag)
        let section = button.tag
        var indexPaths = [IndexPath]()
       for row in 0..<subject[section].subjects.count
       {
            let indexpath = IndexPath(row: row, section: section)
            indexPaths.append(indexpath)
        }
       
        let isExpanded = subject[section].isExpanded
        subject[section].isExpanded = !isExpanded
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
             button.setImage(plus, for: .normal)
           
        }else{
            
            tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.top)
             button.setImage(minus, for: .normal)
        
        }
     
        
        
    }
 
    }
    
enum choice : String {
    case verySatisfied = "very Satisfied"
    case satisfied = "satisfied"
    case notBad = "not bad"
    case unsatisfied = "unsatisfied"
    case veryUnsatisfied = "very unsatisfied"
    
}
    
    
  


