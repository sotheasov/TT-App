//
//  HomeViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeMenyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var homeMenuCollectionView: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var sliderImageView: UIImageView!
    
    let menuList : [Menu] = [
        Menu(id: 0, title: "Product", imageUrl: "internet_package"),
        Menu(id: 1, title: "Payment", imageUrl: "get_cash"),
        Menu(id: 2, title: "Help Desk", imageUrl: "ustomer_support"),
        Menu(id: 3, title: "Speed Test", imageUrl: "speed"),
        Menu(id: 4, title: "Scan QR", imageUrl: "qr_black"),
        Menu(id: 5, title: "Location", imageUrl: "Map")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addRightButton()
        addLeftButton()
        registerCollectionViewCell()
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
        titleLabel.text = "TURBOTECH"
        titleLabel.font = UIFont.systemFont(ofSize: NAV.HOME_NAV_TITLE_SIZE, weight: .semibold)
        titleLabel.textColor = NAV.HOME_NAV_COLOR_WHITE
        lNavVIew.addSubview(titleLabel)
        let leftBarButton = UIBarButtonItem(customView: lNavVIew)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapOnRightButton(){
        print("WORK")
    }

}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
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
//                let productVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProductViewControllerID")
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
