//
//  TabBarController.swift
//  OfferSDK Tester
//
//  Created by Rashiya, Brijesh (Contractor) on 03/07/24.
//

import UIKit
import OfferSDK

class TabBarController: UITabBarController {
    
    var upperLineView: UIView!
    let spacing: CGFloat = 12
    var offerVC : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        addBackButton()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
//            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
//        }
        
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.isHidden = true
        
        let frameworkBundleID  = "com.syw.OfferSDK";
        let bundle = Bundle(identifier: frameworkBundleID)
        
//        let vc = OfferVC(nibName: "OfferVC", bundle: bundle)
//        let vc = OfferMainVC(nibName: "OfferMainVC", bundle: bundle)
        
        
//        let vcNormal = UIViewController()
//        vcNormal.view.backgroundColor = .white
        
        
        
        let vc1 = UINavigationController(rootViewController: VCNormal())
        let vc2 = UINavigationController(rootViewController: VCNormal())
//        let vc3 = UINavigationController(rootViewController: vc)
        let vc3 = offerVC
        let vc4 = UINavigationController(rootViewController: VCNormal())
        
        
        vc1.title = "Home"
        vc2.title = "Categories"
        vc3?.title = "Offer"
        vc4.title = "Profile"
        
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "categories")
        vc3?.tabBarItem.image = UIImage(named: "offer")
        vc4.tabBarItem.image = UIImage(named: "user")
        
        
        self.setViewControllers([vc1,vc2,vc3!,vc4], animated: true)
        
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false) {
        
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime{
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y:    tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 4))
        upperLineView.backgroundColor = UIColor.systemPink
        tabBar.addSubview(upperLineView)
    
    }
    
    func addBackButton() {
        var backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal)
//        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @IBAction func backAction(_ sender: UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }

}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        addTabbarIndicatorView(index: self.selectedIndex)
    }
}



class VCNormal: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
//        let app = UINavigationBarAppearance()
//            app.backgroundColor = .white
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app
//        title = "home"
        
    }
}
