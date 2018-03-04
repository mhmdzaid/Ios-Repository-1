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
   //outlets
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.delegate = self
        tableView.dataSource = self
        infoView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"cell" ) as? scheduleCellTableViewCell else{
            return UITableViewCell()
        }
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
        
    }
    
    
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle(days[section], for: .		normal)
        button.setTitleColor(#colorLiteral(red: 0.1379489751, green: 0.6505600847, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.textAlignment = NSTextAlignment.left
       let imageViewIn = UIImageView(frame: CGRect(x: 32, y: 35, width:30, height: 10))
        let signImage =  UIImage(named: "Shape 1")
        imageViewIn.backgroundColor = UIColor.clear
       imageViewIn.image = signImage
       button.addSubview(imageViewIn)
       
       
        
        
        button.addTarget(self, action: #selector(expandCollapse(button:)), for: .touchUpInside)
        button.tag = section
        
      
        
        
              return button
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    @objc func expandCollapse(button:UIButton){
        
        print(button.tag)
        let section = button.tag
        var indexPaths = [IndexPath]()
         let signImage =  UIImage(named: "Shape 1")
         let signImage2 =  UIImage(named: "add")
         let imageViewIn = UIImageView(frame: CGRect(x: 32, y: 35, width:30, height: 10))
        if imageViewIn.image == signImage{
            imageViewIn.image = signImage2
        }
        else{imageViewIn.image = signImage}
       for row in 0..<subject[section].subjects.count
       {
            let indexpath = IndexPath(row: row, section: section)
            indexPaths.append(indexpath)
        }
       
        let isExpanded = subject[section].isExpanded
        subject[section].isExpanded = !isExpanded
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        }else{
            tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.top)
        }
        
        
    }
 
    }
    
   
    
    
  


