//
//  FAQsTableViewController.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class FAQsTableViewController: UITableViewController {

    var FAQsList = [SupportQuestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setData()
    }
    
    func setupView(){
        let nib = UINib(nibName: "FAQsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FAQsTableViewCellID")
        
        let headerNib = UINib(nibName: "FAQsTableViewHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "FAQsTableViewHeaderID")
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "launchScreen"))
    }
    
    func setData(){
        let helpDeskViewModel = HelpDeskViewModel()
        DispatchQueue.main.async {
            helpDeskViewModel.fetchAllFAQs { (list) in
                self.FAQsList = list
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return FAQsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FAQsList[section].isCollapse == true ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQsTableViewCellID", for: indexPath) as! FAQsTableViewCell
//        cell.setData(answer: "Answer ")
        cell.backgroundColor = .clear
        cell.setData(answer: FAQsList[indexPath.section].answerEn)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FAQsTableViewHeaderID") as! FAQsTableViewHeader
//        header.setData(question: "Question")
        header.setData(question: FAQsList[section].questionEn)
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapSection(_:)))
        header.isUserInteractionEnabled = true
        header.addGestureRecognizer(tap)
        header.tag = section
        return header
    }
    
    @objc
    func tapSection(_ sender : UITapGestureRecognizer){
        guard let tag = sender.view?.tag else {
            return
        }
        print(tag)
        self.FAQsList[tag].isCollapse = self.FAQsList[tag].isCollapse == true ? false : true
        self.tableView.reloadSections([tag], with: .fade)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
