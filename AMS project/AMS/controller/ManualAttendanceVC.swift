//
//  ManualAttendanceVC.swift
//  AMS
//
//  Created by mohamed zead on 3/18/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class ManualAttendanceVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.layer.borderWidth  =  1.5
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.cornerRadius = 13
        searchBar.clipsToBounds = true
        
    }
    @IBOutlet weak var searchBar: UITextField!
    

    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? StudentCell else{
            return UITableViewCell()
        }
     cell.studentName.text = "ahmed"
     cell.studentImage.layer.cornerRadius = 39
     cell.studentImage.clipsToBounds = true

    return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
