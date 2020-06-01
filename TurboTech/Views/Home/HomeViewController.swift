//
//  HomeViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Network

class HomeViewController: UIViewController {

    @IBOutlet weak var homeMenyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var homeMenuCollectionView: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var sliderImageView: UIImageView!
    
    var menuList = [Menu]()
    
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name(rawValue: "changed"), object: nil)
        setUp()
        addRightButton()
        addLeftButton()
        registerCollectionViewCell()
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        didTapOnRightButton()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
            } else {
                print("There's no internet connection.")
                self.showAndDismissAlert(title: "បើកសេវាតិចទៅ", message: "សុំអង្វរ", style: .alert, second: 5)
            }
        }
        
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
    @objc
    func changeLanguage(){
        addLeftButton()
        menuList = [
            Menu(id: 0, title: "product".localized.localized, imageUrl: "internet_package"),
            Menu(id: 1, title: "payment".localized, imageUrl: "get_cash"),
            Menu(id: 2, title: "help desk".localized, imageUrl: "ustomer_support"),
            Menu(id: 3, title: "speed test".localized, imageUrl: "speed"),
            Menu(id: 4, title: "scan qr".localized, imageUrl: "qr_black"),
            Menu(id: 5, title: "location".localized, imageUrl: "Map")
        ]
        homeMenuCollectionView.reloadData()
    }
     
    var imageNum = 0
    let imageStr = ["1","2","3","4","5"]
    @objc
    func changeImage(){
        if imageNum > imageStr.count - 1 {imageNum = 0}
        let image = UIImage(named: imageStr[imageNum])
        let url = URL(string: imageStr[imageNum])
        sliderImageView.kf.setImage(with: url, placeholder: image)
        imageNum = imageNum + 1
    }
    
    private func setUp(){
//        self.navigationController?.navigationBar.barTintColor = COLOR.RED
//        setUpNavigation()
    }
    
    private func setUpNavigation(){
        let height: CGFloat = 0 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
    }
    
    func addRightButton(){
        
        let rNavView = UIView(frame: CGRect(x: 0, y: 0, width: 90,height: 40))
        
        let notificationBtn = UIButton(frame: CGRect(x: 0,y: 0, width: 40, height: 40))
        notificationBtn.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        notificationBtn.tintColor = .white
        notificationBtn.contentVerticalAlignment = .fill
        notificationBtn.contentHorizontalAlignment = .fill
        notificationBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        notificationBtn.addTarget(self, action: #selector(self.didTapOnRightButton), for: .touchUpInside)
        
        let profileImageView = UIImageView(frame: CGRect(x: 50, y: 2, width: 36, height: 36))
        profileImageView.image = UIImage(named: "love.jpg")
        profileImageView.contentMode = UIView.ContentMode.scaleAspectFit
        profileImageView.layer.cornerRadius = SIZE.RADIOUS_IMAGE
        profileImageView.layer.masksToBounds = true
        rNavView.addSubview(profileImageView)
        rNavView.addSubview(notificationBtn)

        let rightBarButton = UIBarButtonItem(customView: rNavView)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addLeftButton(){
        let lNavVIew = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
        titleLabel.textAlignment = .left
        titleLabel.text = "turbotech".localized
        titleLabel.font = UIFont.systemFont(ofSize: NAV.HOME_NAV_TITLE_SIZE, weight: .semibold)
        titleLabel.textColor = NAV.HOME_NAV_COLOR_WHITE
        lNavVIew.addSubview(titleLabel)
        let leftBarButton = UIBarButtonItem(customView: lNavVIew)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapOnRightButton(){
        if LanguageManager.shared.language == "km" {
            LanguageManager.shared.language = "en"
        }
        else {
            LanguageManager.shared.language = "km"
        }
        NotificationCenter.default.post(name: Notification.Name("changed"), object: nil)
    }

}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeMenuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCellID", for: indexPath) as! MenuCollectionViewCell
        cell.customCell(menu: menuList[indexPath.item])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    func registerCollectionViewCell()  {
        homeMenuCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCellID")
        homeMenuCollectionView.delegate = self
        homeMenuCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow : CGFloat = 2
        let itemPerColumn : CGFloat = 3
        let lineSpacing: CGFloat = 0.8
        let itemSpacing: CGFloat = 0.4
        let size = self.menuView.frame.size

        let width = (size.width - (itemPerRow * itemSpacing)) / itemPerRow
        let height = (size.height - (itemPerColumn * lineSpacing)) / itemPerColumn
        return CGSize(width: width, height: height)
    }
    
    @objc
    func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.homeMenuCollectionView)
        let indexPath = self.homeMenuCollectionView.indexPathForItem(at: location)
        if let index = indexPath {
            print("Got clicked on index: \(index)!")
            switch index.item {
            case 0:
                print("Product")
                let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
                productVC.modalPresentationStyle = .fullScreen
                productVC.setNavigationTitle(title: "Product")
                productVC.setTypeId(id: 0)
                self.navigationController?.pushViewController(productVC, animated: true)
            case 1:
                print("Payment")
            case 2:
                print("Help Desk")
                let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
                productVC.modalPresentationStyle = .fullScreen
                productVC.setNavigationTitle(title: "Product")
                productVC.setTypeId(id: 2)
                self.navigationController?.pushViewController(productVC, animated: true)
            case 3:
                print("Speed Test")
                let speedTestVC = storyboard?.instantiateViewController(identifier: "SpeedTestViewControllerID") as! SpeedTestViewController
                speedTestVC.navigationItem.title = "Speed Test"
                self.navigationController?.pushViewController(speedTestVC, animated: true)
            case 4:
                print("Scan QR")
            case 5:
                print("Location")
                /*
                print(AppDelegate.position)
                switch AppDelegate.position {
                case .Admin :
                    let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                    let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.ADMIN) as! AdminTableViewController
                    openVC.navigationItem.title = "ADMIN"
                    self.navigationController?.pushViewController(openVC, animated: true)
                case .Finance :
                    let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                    let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.FINANCE) as! FinanceTableViewController
                    openVC.navigationItem.title = "Finance"
                    self.navigationController?.pushViewController(openVC, animated: true)
                case .HR :
                    let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                    let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.ADMIN) as! AdminTableViewController
                    openVC.navigationItem.title = "HR"
                    self.navigationController?.pushViewController(openVC, animated: true)
                case .Sale :
                    let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                    let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.SALE) as! SaleTableViewController
                    openVC.navigationItem.title = "Sale"
                    self.navigationController?.pushViewController(openVC, animated: true)
                }
                */
                /*
                let locationVC = storyboard?.instantiateViewController(identifier: "PopLocationViewControllerID") as! PopLocationViewController
                locationVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(locationVC, animated: true)
                */
                
                let locationVC = storyboard?.instantiateViewController(identifier: "UserLocationViewControllerID") as! UserLocationViewController
                locationVC.modalPresentationStyle = .fullScreen
                locationVC.navigationItem.title = "Location"
                self.navigationController?.pushViewController(locationVC, animated: true)
                
            default:
                print("")
            }
        }
    } 
    
}
