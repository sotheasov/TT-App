//
//  DepartmentViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {
    
    //IBOutlet of DepartmentViewController
    @IBOutlet weak var departmentTableView: UITableView!
    
//    let data = ["Information", "Department", "Language", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departmentTableView.delegate = self
        departmentTableView.dataSource = self
        departmentTableView.tableFooterView = UIView()
        
        // Register Department TableViewCell
        departmentTableView.register(UINib(nibName: "DepartmentTableViewCell", bundle: nil), forCellReuseIdentifier: "departmentCellItem")
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DepartmentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentCellItem") as! DepartmentTableViewCell
                return cell
    }
}
