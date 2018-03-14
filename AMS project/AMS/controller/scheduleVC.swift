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
   
    var subject = [
        
        ExpandableNames(isExpanded: true, subjects: ["subject":"computer vision","time" : "10:12 AM","type" : "section" ]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"Neural network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:   ["subject":"image processing","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"operating system","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects:  ["subject":"Network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects: ["subject":"Network","time" : "2:00","type" : "lecture"]),
        ExpandableNames(isExpanded: true, subjects: ["subject":"algorithm","time" : "2:00","type" : "lecture"])
                                                                                                                        ]
    
    let days  = ["  saturday","  sunday","  monday","  tuseday","  wednisday ","  thursday"]
    let minus =  UIImage(named: "Shape 1")
    let plus = UIImage(named: "pls")
    //outlets
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
    
    //ibActions
    
    @IBAction func okPressed(_ sender: Any) {
        infoView.isHidden = true
       tableView.alpha = 1
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
       tableView.delegate = self
        tableView.dataSource = self
        infoView.isHidden = true
        profImageInfo.layer.cornerRadius = 25
        profImageInfo.clipsToBounds = true
        profImageInfo.backgroundColor = #colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1)
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
    
   
    
    
  


