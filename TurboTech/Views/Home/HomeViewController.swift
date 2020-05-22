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
        Menu(title: "Product", imageUrl: "internet_package"),
        Menu(title: "Payment", imageUrl: "https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg"),
        Menu(title: "Help Desk", imageUrl: "https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg"),
        Menu(title: "Speed Test", imageUrl: "speed"),
        Menu(title: "Scan QR", imageUrl: "https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg"),
        Menu(title: "Location", imageUrl: "https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addRightButton()
        addLeftButton()
        registerCollectionViewCell()
    }
    
    private func setUp(){
        self.navigationController?.navigationBar.barTintColor = COLOR.RED
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
        
        let profileImageView = UIImageView(frame: CGRect(x: 50, y: 0, width: 40, height: 40))
        profileImageView.image = UIImage(named: "love.jpg")
        profileImageView.contentMode = UIView.ContentMode.scaleAspectFit
        profileImageView.layer.cornerRadius = 20
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
        titleLabel.font = titleLabel.font.withSize(24)
        titleLabel.textColor = .white
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
                self.navigationController?.pushViewController(productVC, animated: true)
            case 1:
                print("Payment")
            case 2:
                print("Help Desk")
            case 3:
                print("Speed Test")
            case 4:
                print("Scan QR")
            case 5:
                print("Location")
            default:
                print("")
            }
        }
    } 
    
}
