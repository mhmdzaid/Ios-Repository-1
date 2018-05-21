//
//  scheduleVC.swift
//  AMS
//
//  Created by mohamed zead on 2/28/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class scheduleVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
   
    
    //lectures and sections data
 
    var i = 0
    var loginType : loginType!
    var studentID : Int = 9
    var studentLevel : Int?
    var instructorID :Int = 0
    
    var questions = [JSON](repeating:"", count: 5){
        didSet{
            option1.setTitle(questions[0]["option1"].stringValue, for: .normal)
            option2.setTitle(questions[0]["option2"].stringValue, for: .normal)
            option3.setTitle(questions[0]["option3"].stringValue, for: .normal)
            option4.setTitle(questions[0]["option4"].stringValue, for: .normal)
        }
    }
    var questionsToPost : [String : Any] = [:]
    var choices  = [String](repeating:"", count: 5){   //storing choices selected by the student
        didSet{
            
            questionsToPost = ["student_id": studentID]
            for (index,choice) in choices.enumerated()
            {
                questionsToPost["answer\(index+1)"] = choice
            }
            print("question to post ==============>: \(questionsToPost)")
        
        }
    }
    var sideMenuVisible = false
    var choice = ""
    var schedule : [JSON]!
    var subject : [String :[ExpandableNames]]! = ["Saturday":[],"Sunday":[],"Monday":[],"Tuesday":[],"Wednesday":[],"Thursday":[]]
        
    
        
    
    
    let days  = ["Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday"]
    let minus =  UIImage(named: "Shape 1")
    let plus = UIImage(named: "pls")
    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
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
    //feedback options
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    //instructor View outlets
    @IBOutlet weak var instructorView: UIView!
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var startedAt: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var studentNumber: UILabel!
    @IBOutlet weak var manualAttBtn: UIButton!
    @IBOutlet weak var endSessionBtn: UIButton!
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
    @IBAction func menuBtnSelected(_ sender: Any) {
        if sideMenuVisible == true{
            sideMenuVisible = false
            self.view.alpha = 1
        }
        else{
            sideMenuVisible = true
            self.view.alpha = 0.85
        }
    }
    // getting questions from the server
    func fetchQuestions(){
        
        Alamofire.request("http://syntax-eg.esy.es/api/questionsByAdmin").responseJSON { (Response) in
            if  let response = Response.result.value{
               // print("===========================\(Response)")
            let qust = JSON(response)
                
                self.questions =  qust["admin_Questions"].arrayValue
                
                
                
                
            print("===========================********\(self.questions)")
            }else{
                print("connection failed ")
            }
        }
        
    }
    
    // here we actually store the choice  of the radio button
    
    @IBAction func choiceSelected(_ sender: DLRadioButton) {
       let tag = sender.tag
        
        switch tag {
        case -1:
            choice = option1.currentTitle!
            break
        case -2 :
            choice = option2.currentTitle!
            break
        case -3 :
            choice = option3.currentTitle!
            break
        case -4:
            choice = option4.currentTitle!
            break
      
        default:
            print("wrong coding ")
        }
    }
    @IBAction func showHidePassword(_ sender: Any) {
        if passField.isSecureTextEntry == true {
            passField.isSecureTextEntry = false
        }else{
            passField.isSecureTextEntry = true
        }
    }
    
    // functionality of backbutton of the feedback view
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if i>0
        {
            if i == 5
            {
                
                let circle =  feedbackView.viewWithTag(i-1)as? UIImageView
                circle?.image = UIImage(named: "ccover")
                i-=1
                question.text = questions[i]["question"].stringValue
                option1.setTitle(questions[i]["option1"].stringValue, for: .normal)
                option2.setTitle(questions[i]["option2"].stringValue, for: .normal)
                option3.setTitle(questions[i]["option3"].stringValue, for: .normal)
                option4.setTitle(questions[i]["option4"].stringValue, for: .normal)
            }
            let circle =  feedbackView.viewWithTag(i)as? UIImageView
            circle?.image = UIImage(named: "ccover")
            i-=1
            question.text =  questions[i]["question"].stringValue
            option1.setTitle(questions[i]["option1"].stringValue, for: .normal)
            option2.setTitle(questions[i]["option2"].stringValue, for: .normal)
            option3.setTitle(questions[i]["option3"].stringValue, for: .normal)
            option4.setTitle(questions[i]["option4"].stringValue, for: .normal)
            
        }
       print(i)
    }
     // functionality of next button of the feedback view
    @IBAction func nextButtonPressed(_ sender: Any) {
        print("------------------------\(choice)")
        choices[i] = choice
        
        if i<5
        {
            
            if i == 4
            {
           
            question.text = questions[i]["question"].stringValue
            option1.setTitle(questions[i]["option1"].stringValue, for: .normal)
            option2.setTitle(questions[i]["option2"].stringValue, for: .normal)
            option3.setTitle(questions[i]["option3"].stringValue, for: .normal)
            option4.setTitle(questions[i]["option4"].stringValue, for: .normal)
            i+=1
            if i == 5
            {
                thankingView.isHidden = false
                feedbackView.isHidden = true
                let url = "http://syntax-eg.esy.es/api/questionsByStudtents"
                let header = ["content-type" : "application/json"]
                Alamofire.request(url, method: .post, parameters: questionsToPost, encoding: JSONEncoding.default, headers: header).responseJSON{ (response) in
                    
                }
            }
            
            print("---------------------\(choices)")
            return
            }
            i+=1
            
            question.text = questions[i]["question"].stringValue
            option1.setTitle(questions[i]["option1"].stringValue, for: .normal)
            option2.setTitle(questions[i]["option2"].stringValue, for: .normal)
            option3.setTitle(questions[i]["option3"].stringValue, for: .normal)
            option4.setTitle(questions[i]["option4"].stringValue, for: .normal)
            let circle =  feedbackView.viewWithTag(i)as? UIImageView
            circle?.image = UIImage(named: "circle")
            print(i)

        }
        if i == 5
        {
        thankingView.isHidden = false
        feedbackView.isHidden = true
        
       
        
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.fetchQuestions()
         self.layoutConfig()
        self.view.backgroundColor = UIColor.black
      

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        if   revealViewController().loginType ==  0{
            self.loginType = .student
            self.studentLevel = Int(revealViewController().studentLevel)
        }else{
            self.loginType = .instructor
        }
        print("-----------------------\(loginType)--------------\(studentLevel)-----------")
        
    }
    
    func layoutConfig()->(){
        let url = "http://syntax-eg.esy.es/api/schedule"
        fetchingSchedule(url:url) {        // rendering tableView data after completion of the request
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            print("^^^^^^^^^^^^^^^^^^^^^^^^^\(self.subject["Wednesday"]?.count)^^^^^^^^^^^^^^^^")
        }
        profImageInfo.layer.cornerRadius = 25
        profImageInfo.clipsToBounds = true
        profImageInfo.backgroundColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        thankingView.layer.borderColor = UIColor.black.cgColor
        thankingView.layer.borderWidth = 0.3
        passwordView.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.borderWidth = 0.3
        passField.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        passField.layer.borderWidth = 1
        passField.layer.cornerRadius = 10
        ok.layer.cornerRadius = 8
        print(questions)
        feedbackView.layer.borderWidth = 0.7
        feedbackView.layer.borderColor = UIColor.black.cgColor
        backBtn.layer.borderWidth = 1.3
        backBtn.layer.borderColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
        backBtn.layer.cornerRadius = 20
        nextBtn.layer.cornerRadius = 20
        manualAttBtn.layer.cornerRadius = 20
        endSessionBtn.layer.cornerRadius = 20
        instructorView.isHidden = true
    }
    
    
    func fetchingSchedule(url : String,completion :@escaping ()->()){
        Alamofire.request(url).responseJSON{ (Response) in
            if let dataFromServ = Response.result.value{
                let responseINJson = JSON(dataFromServ)
                
                self.schedule = responseINJson["schedule"].arrayValue
                
                for sub in self.schedule
                {
                    
                    let subjectName = sub["subjectName"].stringValue
                    let time = sub["startTime"].stringValue
                    let type = sub["type"].stringValue
                    let location = sub["Location"].stringValue
                    let professorName = sub["instructorName"].stringValue
                    let totalMarks = sub["totalMark"].stringValue
                    let day = sub["day"].stringValue
                    print("day ===== = = = = =\(day) ")
                    switch day {
                    case "Saturday":
                        self.subject["Saturday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                    case "Sunday":
                         self.subject["Sunday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                    case "Monday":
                         self.subject["Monday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                    case "Tuesday":
                         self.subject["Tuesday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                    case "Wednesday":
                         self.subject["Wednesday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                    case "Thursday":
                        self.subject["Thursday"]?.append(ExpandableNames(isExpanded: true, subjectInfo:["subject": subjectName, "time" : time,"type" : type,"location":location,"ProfessorName":professorName,"totalMarks":totalMarks]))
                        break
                        
                    default :
                        break
                    }
                    
                }
               
            }else{
                print("connection error ")
            }
            completion()
        }
        
    }
   
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"cell" ) as? scheduleCellTableViewCell else{
            return UITableViewCell()
        }
        
        cell.ProfImage.layer.cornerRadius = 33
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1.2
        cell.ProfImage.clipsToBounds = true
        cell.ProfImage.backgroundColor = UIColor.white
        switch indexPath.section {
        case 0:
            cell.timeLbl.text = subject["Saturday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Saturday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Saturday"]![indexPath.row].subjectInfo["type"]
            break
        case 1 :
            
            cell.timeLbl.text = subject["Sunday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Sunday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Sunday"]![indexPath.row].subjectInfo["type"]
            
            break
        case 2 :
            cell.timeLbl.text = subject["Monday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Monday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Monday"]![indexPath.row].subjectInfo["type"]

            break
        case 3 :
            cell.timeLbl.text = subject["Tuesday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Tuesday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Tuesday"]![indexPath.row].subjectInfo["type"]
            break
        case 4:
            cell.timeLbl.text = subject["Wednesday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Wednesday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Wednesday"]![indexPath.row].subjectInfo["type"]
            break
        case 5 :
            cell.timeLbl.text = subject["Thursday"]![indexPath.row].subjectInfo["time"]
            cell.subjectLbl.text = subject["Thursday"]![indexPath.row].subjectInfo["subject"]
            cell.TypeLbl.text = subject["Thursday"]![indexPath.row].subjectInfo["type"]
            break
        default:
            break
        }
     
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // for expanding and collapsing
        
        
        if !subject[days[section]]![0].isExpanded{
            return 0
        }
      
        return self.subject[days[section]]!.count
      
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        infoView.isHidden = false
        thankingView.isHidden = true
        
        switch indexPath.section {
        case 0:
            subjectInfo.text = subject["Saturday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Saturday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Saturday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Saturday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Saturday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        case 1:
            subjectInfo.text = subject["Sunday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Sunday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Sunday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Sunday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Sunday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        case 2:
            subjectInfo.text = subject["Monday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Monday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Monday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Monday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Monday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        case 3:
            subjectInfo.text = subject["Tuesday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Tuesday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Tuesday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Tuesday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Tuesday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        case 4:
            subjectInfo.text = subject["Wednesday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Wednesday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Wednesday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Wednesday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Wednesday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        case 5:
            subjectInfo.text = subject["Thursday"]![indexPath.row].subjectInfo["subject"]
            startTime.text = subject["Thursday"]![indexPath.row].subjectInfo["time"]
            attendanceLocation.text = subject["Thursday"]![indexPath.row].subjectInfo["location"]
            professorNameInfo.text = subject["Thursday"]![indexPath.row].subjectInfo["ProfessorName"]
            self.marks.text = subject["Thursday"]![indexPath.row].subjectInfo["totalMarks"]! + " Marks"

            break
        default:
            break
        }
        
        
       
         tableView.alpha = 0.4
      
    }
    
    
    
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // adding button view as header of the table to work as expand collapse menu
        let button = UIButton(type: .system)
        
        button.setTitle("    \(days[section])", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.textAlignment = NSTextAlignment.left
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(expandCollapse(button:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.tag = section
        button.setImage(minus, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        print("check ------------- \(days[section])")
        

        if subject[days[section]]![0].isExpanded{
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
    
    @objc func expandCollapse(button:UIButton){ //here we check if expanded or not
       
        thankingView.isHidden = true
        print(button.tag)
        let section = button.tag
        var indexPaths = [IndexPath]()
       
      //  print("number of days of selected section \(self.subject[dayss[section]])")
        
        for row in 0..<self.subject[days[section]]!.count
       {
            let indexpath = IndexPath(row: row, section: section)
            indexPaths.append(indexpath)
        }
        var isExpanded  : Bool!
        
        isExpanded = subject[days[section]]![0].isExpanded
        
        
        subject[days[section]]![0].isExpanded = !isExpanded
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
             button.setImage(plus, for: .normal)
           
        }else{
            
            tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.top)
            self.tableView.scrollToRow(at: indexPaths[indexPaths.count-1], at: UITableViewScrollPosition.bottom, animated: true)
             button.setImage(minus, for: .normal)
        
        }
     
        
        
    }
 
    }
    

    
    
  


