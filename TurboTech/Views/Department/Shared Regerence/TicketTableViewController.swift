//
//  TicketTableViewController.swift
//  TurboTech
//
//  Created by sq on 6/16/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import SwipeCellKit

class TicketTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        registerCell()
        addRightButton()
    }
    
    private func addRightButton(){
        
//        let rNavView = UIView(frame: CGRect(x: 0, y: 0, width: 90,height: 40))
//
//        let notificationBtn = UIButton(frame: CGRect(x: 0,y: 0, width: 40, height: 40))
//        notificationBtn.setImage(UIImage(named: "bell.fill"), for: .normal)
//        notificationBtn.tintColor = .white
//        notificationBtn.contentVerticalAlignment = .fill
//        notificationBtn.contentHorizontalAlignment = .fill
//        notificationBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        notificationBtn.addTarget(self, action: #selector(self.didTapOnRightButton), for: .touchUpInside)
//
//        let profileImageView = UIImageView(frame: CGRect(x: 50, y: 2, width: 36, height: 36))
//        let image = UIImage(named: "user-circle")
//        profileImageView.image = image
//        if UserDefaults.standard.bool(forKey: "isLogin") && AppDelegate.user != nil {
//            print(AppDelegate.user!.imageUrl)
//            let url = URL(string: AppDelegate.user!.imageUrl)
//            profileImageView.kf.setImage(with: url, placeholder: image)
//        } else {
//            profileImageView.image = image
//        }
//
//        profileImageView.contentMode = .scaleAspectFill
//        profileImageView.layer.cornerRadius = SIZE.RADIOUS_IMAGE
//        profileImageView.layer.masksToBounds = true
//        rNavView.addSubview(profileImageView)
//        rNavView.addSubview(notificationBtn)

//        let rightBarButton = UIBarButtonItem(customView: rNavView)
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "add-blue"), style: .plain, target: self, action: #selector(createTicket(_:)))
    }
    
    @objc func createTicket(_ sender : Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateTicketViewControllerID") as! CreateTicketViewController
        self.present(vc, animated: true, completion: nil)
        
//        self.presentationController
    }
    
    private func registerCell(){
        tableView.register(UINib(nibName: "TicketTableViewCell", bundle: nil), forCellReuseIdentifier: "TicketTableViewCellID")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTableViewCellID") as! TicketTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.tableView.frame.size.height
        if (height < 600){
            return height / SIZE.NUM_ROW_PRO_SMALL
        }
        else if (height < 800) {
            return height / SIZE.NUM_ROW_PRO_MEDIUM
        }
        else {
            return height / SIZE.NUM_ROW_PRO_LARGE
        }
    }
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal, title: "edit") { (action, view, success) in
//            success(true)
//        }
//        action.image = UIImage(named: "edit-g")
//        
//        return UISwipeActionsConfiguration(actions: [action])
//    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
}

extension TicketTableViewController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        

        let deleteAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            print("hello delete")
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "edit")

        return [deleteAction]
    }
}

