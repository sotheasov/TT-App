//
//  MainViewController.swift
//  TurboTech
//
//  Created by sq on 6/11/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
//
////    @IBOutlet weak var tabBar: UITabBar!
//    var customTabBar: TabNavigationMenu!
//    var tabBarHeight: CGFloat = 67.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadTabBar()
//    }
//
//    private func loadTabBar() {
//        let tabItems: [TabItem] = [.home, .location, .message, AppDelegate.isLogin ? .profile : .login]
//        self.setupCustomTabBar(tabItems) { (controllers) in
//            self.viewControllers = controllers
//        }
//
//        self.selectedIndex = 0 // default our selected index to the first item
//    }
//
//    // Build the custom tab bar and hide default
//    private func setupCustomTabBar(_ items: [TabItem], completion: @escaping ([UIViewController]) -> Void){
//        let frame = tabBar.frame
//        var controllers = [UIViewController]()
//
//        // hide the tab bar
//        tabBar.isHidden = true
//
//        self.customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
//        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
//        self.customTabBar.clipsToBounds = true
//        self.customTabBar.itemTapped = self.changeTab
//
//        // Add it to the view
//        self.view.addSubview(customTabBar)
//
//        // Add positioning constraints to place the nav menu right where the tab bar should be
//        NSLayoutConstraint.activate([
//            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
//            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
//            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
//            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // Fixed height for nav menu
//            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
//        ])
//
//        for i in 0 ..< items.count {
//            controllers.append(items[i].viewController) // we fetch the matching view controller and append here
//        }
//
//        self.view.layoutIfNeeded() // important step
//        completion(controllers) // setup complete. handoff here
//    }
//
//    func changeTab(tab: Int) {
//        self.selectedIndex = tab
//        print("selected: \(self.selectedIndex) ")
//        print("controller: \(self.viewControllers![self.selectedIndex])")
//    }
//
//}
//
//enum TabItem: String, CaseIterable {
//    case home = "home"
//    case location = "locaiton"
//    case message = "message"
//    case profile = "profile"
//    case login = "login"
//
//
//    var viewController: UIViewController {
//        switch self {
//        case .home: return HomeViewController()
//        case .location: return LocationViewController()
//        case .message: return MessageViewController()
//        case .profile: return ProfileViewController()
//        case .login: return LoginViewController()
//        }
//    }
//
//    var icon: UIImage? {
//        switch self {
//        case .home: return UIImage(named: "house.fill")
//        case .location: return UIImage(named: "house.fill")
//        case .message: return UIImage(named: "house.fill")
//        case .profile: return UIImage(named: "house.fill")
//        case .login: return UIImage(named: "house.fill")
//        }
//    }
//
//    var displayTitle: String {
//        return self.rawValue.localized
//    }
//}
//
//class TabNavigationMenu: UIView {
//
//    var itemTapped: ((_ tab: Int) -> Void)?
//    var activeItem: Int = 0
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    convenience init(menuItems: [TabItem], frame: CGRect) {
//        self.init(frame: frame)
//        self.layer.backgroundColor = UIColor.white.cgColor
//
//        for i in 0 ..< menuItems.count {
//            let itemWidth = self.frame.width / CGFloat(menuItems.count)
//            let leadingAnchor = itemWidth * CGFloat(i)
//
//            let itemView = self.createTabItem(item: menuItems[i])
//            itemView.tag = i
//
//            self.addSubview(itemView)
//
//            itemView.translatesAutoresizingMaskIntoConstraints = false
//            itemView.clipsToBounds = true
//
//            NSLayoutConstraint.activate([
//                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
//                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
//                itemView.topAnchor.constraint(equalTo: self.topAnchor),
//            ])
//        }
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        self.activateTab(tab: 0)
//    }
//
//    func createTabItem(item: TabItem) -> UIView {
//        let tabBarItem = UIView(frame: CGRect.zero)
//        let itemTitleLabel = UILabel(frame: CGRect.zero)
//        let itemIconView = UIImageView(frame: CGRect.zero)
//
//        itemTitleLabel.text = item.displayTitle
//        itemTitleLabel.font = UIFont.systemFont(ofSize: 14)
//        itemTitleLabel.textAlignment = .center
//        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        itemTitleLabel.clipsToBounds = true
//
//        itemIconView.image = item.icon!.withRenderingMode(.automatic)
//        itemIconView.translatesAutoresizingMaskIntoConstraints = false
//        itemIconView.clipsToBounds = true
//        tabBarItem.layer.backgroundColor = UIColor.white.cgColor
//        tabBarItem.addSubview(itemIconView)
//        tabBarItem.addSubview(itemTitleLabel)
//        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
//        tabBarItem.clipsToBounds = true
//        NSLayoutConstraint.activate([
//            itemIconView.heightAnchor.constraint(equalToConstant: 25), // Fixed height for our tab item(25pts)
//            itemIconView.widthAnchor.constraint(equalToConstant: 25), // Fixed width for our tab item icon
//            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
//            itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8), // Position menu item icon 8pts from the top of it's parent view
//            itemIconView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: 35),
//            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13), // Fixed height for title label
//            itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor), // Position label full width across tab bar item
//            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 4), // Position title label 4pts below item icon
//            ])
//        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap))) // Each item should be able to trigger and action on tap
//        return tabBarItem
//    }
//
//    @objc func handleTap(_ sender: UIGestureRecognizer) {
//        self.switchTab(from: self.activeItem, to: sender.view!.tag)
//    }
//
//    func switchTab(from: Int, to: Int) {
//        self.deactivateTab(tab: from)
//        self.activateTab(tab: to)
//    }
//
//    func activateTab(tab: Int) {
//
//        let tabToActivate = self.subviews[tab]
//        let borderWidth = tabToActivate.frame.size.width - 20
//        let borderLayer = CALayer()
//        borderLayer.backgroundColor = UIColor.green.cgColor
//        borderLayer.name = "active border"
//        borderLayer.frame = CGRect(x: 10, y: 0, width: borderWidth, height: 2)
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.8, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
//                tabToActivate.layer.addSublayer(borderLayer)
//                tabToActivate.setNeedsLayout()
//                tabToActivate.layoutIfNeeded()
//            })
//            self.itemTapped?(tab)
//        }
//        self.activeItem = tab
//    }
//
//    func deactivateTab(tab: Int) {
//
//        let inactiveTab = self.subviews[tab]
//        let layersToRemove = inactiveTab.layer.sublayers!.filter({ $0.name == "active border" })
//
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
//                layersToRemove.forEach({ $0.removeFromSuperlayer() })
//                inactiveTab.setNeedsLayout()
//                inactiveTab.layoutIfNeeded()
//            })
//        }
//
//    }
}
