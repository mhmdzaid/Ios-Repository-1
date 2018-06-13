//
//  ManualAttendanceVC.swift
//  AMS
//
//  Created by mohamed zead on 3/18/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ManualAttendanceVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,StudentCellDelegate{
    

    func pauseButtonPressed(cellResume: UIView) {
        cellResume.isHidden = false
    }
    func resumeButtonPressed(cellResume: UIView) {
        cellResume.isHidden = true
    }
   
    
    var students_ids : [Int]! = []
    var students : [String]! = []{
        didSet{
            self.studentsUpdated = self.students
        }
    }
    
    var studentsUpdated :[String]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        fetchStudents {
            self.studentsUpdated = self.students
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
        
      
        }
    override func viewWillAppear(_ animated: Bool) {
        let timer = Timer.scheduledTimer(withTimeInterval:300 , repeats: true) { (Timer) in
            self.fetchStudents {
                
            }
        }
        timer.fire()
        tableView.reloadData()
    }

    @IBOutlet weak var searchBar: UISearchBar!
    

    @IBOutlet weak var tableView: UITableView!
//
//    @IBAction func pausePressed(_ sender: UIButton) {
//        let cell = sender.superview?.superview as! StudentCell
//        let indexPath = tableView.indexPath(for: cell)
//        cell.vieww.isHidden = false
//    }
    
//    @IBAction func resumePressed(_ sender: UIButton) {
//        let cell = sender.superview?.superview as! StudentCell
//        let indexPath = tableView.indexPath(for: cell)
//        cell.vieww.isHidden = false
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsUpdated!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? StudentCell else{
            return UITableViewCell()
        }
     cell.delegate = self
     cell.layer.borderWidth = 0.6
     cell.layer.borderColor = UIColor.black.cgColor
     cell.studentName.text = studentsUpdated![indexPath.row]
     cell.studentImage.layer.cornerRadius = 35
     cell.layer.borderWidth = 1
     cell.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
     cell.id = students_ids[indexPath.row]
     
    return cell
    }
    
   
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            studentsUpdated = students
            tableView.reloadData()
            return
        }
        studentsUpdated = students.filter { (student) -> Bool in
        guard let text = searchBar.text?.lowercased() else{return false}
        return student.lowercased().contains(text)
        }
        tableView.reloadData()
    }
  
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    func fetchStudents(completion : @escaping ()->()){
       
        
        Alamofire.request("http://syntax-eg.esy.es/api/students_in_Location").responseJSON { (Response) in
            if let result = Response.result.value{
            let array = JSON(result)
            let all_Students = array["students_in_Location"].arrayValue
              for student in all_Students
              {
                if !self.students.contains(student["name"].stringValue)
                {
                    self.students.append(student["name"].stringValue)
                    self.students_ids.append(student["id"].intValue)
                }
              }
                
            }
        }
        completion()
    }
    
    }
    
    

