//
//  ViewController.swift
//  OfferSDK Tester
//
//  Created by Rashiya, Brijesh (Contractor) on 28/06/24.
//

import UIKit
import OfferSDK

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var btnOffer1: UIButton!
    @IBOutlet weak var btnOffer2: UIButton!
    
    var offerVC : UIViewController?
    
    //MARK: - Variable
    var localConfig: LocalConfiguration! {
        didSet {
            loadCustomConfiguration()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUi()
        checkRefId()
//        btnOffer1.titleLabel?.font = UIFont.init(name: "Paisley", size: 40)
//        btnOffer2.titleLabel?.font = UIFont.init(name: "Paisley", size: 40)
        
//        yourLabel.font = UIFont.init(name: "Paisley", size: size)
    }

    
    
    func loadCustomConfiguration() {
               
        guard let refId = UserDefaults.standard.value(forKey: "refId") as? String else {
            self.showToast(message: "Please set Ref Id on the Configuration screen.")
            return
        }
        
        let builder = OfferBuilder(refId: refId,
                    environment: self.localConfig.environment,
                    merchantId: self.localConfig.merchantId,
                    organization: self.localConfig.organization,
                    programType: self.localConfig.programType)
                         
        let offerConfig = builder.build()
        offerVC = builder.getOfferVC(config: offerConfig)
    }
    
}

//MARK: - Navigation Bar Methods
private extension ViewController {
    
    func setupUi() {
        setNavigationItems()
    }
    
    func setNavigationItems() {
        let refreshImage = UIImage(systemName: "arrow.clockwise")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let editImage = UIImage(systemName: "pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        let refreshButton = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(refrechRefId))
        
        let editButton = UIBarButtonItem(image: editImage, style: .plain, target: self, action: #selector(openConfigurationScreen))
        
        navigationItem.rightBarButtonItems = [editButton, refreshButton]
        navigationItem.title = "Offer-SDK Tester"
    }
    
    //MARK: - Navigation IBActions
    @objc private func refrechRefId() {
        guard checkRefId() else { return }
        loadCustomConfiguration()
    }
    
    @discardableResult
    func checkRefId() -> Bool {
        guard let refID = UserDefaults.standard.value(forKey: "refId") as? String else {
            self.showToast(message: "Please set Ref Id on the Configuration screen.")
            return false
        }
        
//        let memberNumber = UserDefaults.standard.string(forKey: "Member_Number") ?? ""
        let merchantId = UserDefaults.standard.string(forKey: "Merchant_Id") ?? ""
        
        let organization = UserDefaults.standard.string(forKey: "organization") ?? Constants.organisation
        let programType = UserDefaults.standard.string(forKey: "program_type") ?? ""
        
//        let showMemberNumber = UserDefaults.standard.bool(forKey: "showMemberNumber")
//        let showMemberName = UserDefaults.standard.bool(forKey: "showMemberName")
//        let showExpiryPoints = UserDefaults.standard.bool(forKey: "showExpiringPoints")
//        let sdkVersion = UserDefaults.standard.string(forKey: "sdkVersion") ?? ""
        
        
        localConfig = LocalConfiguration(refId: refID, merchantId: merchantId, environment: Constants.environment, organization: organization, programType: programType)
        
        return true
    }
    
    @objc private func openConfigurationScreen() {
        
        guard let configurationViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConfigurationViewController") as? ConfigurationViewController else { return }
        configurationViewController.configuration = self.localConfig
        configurationViewController.onSaveConfiguration = { [weak self] configuration in
            print(configuration)
            self?.localConfig = configuration
        }
        
        let navigationConroller = UINavigationController(rootViewController: configurationViewController)
        navigationConroller.modalPresentationStyle = .fullScreen
        present(navigationConroller, animated: true)
    }
    
    
}


//MARK: - IBActions - Open Offer SDK
extension ViewController {
    @IBAction func btnOpenOffers_Click(_ sender: UIButton) {
        
        loadCustomConfiguration()
        
//        let bundle = Bundle(for: type(of: self))
        
//        let frameworkBundleID  = "com.syw.OfferSDK";
//        let bundle = Bundle(identifier: frameworkBundleID)
        
        let colorsSetting = ColorSettings(primaryColor: UIColor.systemCyan, secondaryColor: UIColor.yellow, primaryTextColor: UIColor.black, secondaryTextColor: UIColor.white, primaryButtonBGColor: UIColor.blue, secondaryButtonBGColor: UIColor.red)

        ThemeSettings.shared.colorSetting = colorsSetting
        //ThemeSettings.shared.fontSetting = FontSettings(font: UIFont.init(name: "Times New Roman", size: 20) ?? UIFont.systemFont(ofSize: 20))
        ThemeSettings.shared.fontSetting = FontSettings(font: UIFont.init(name: "American Typewriter", size: 40) ?? UIFont.systemFont(ofSize: 20))
        
        
//        let vc = OfferVC(nibName: "OfferVC", bundle: bundle)
//        let vc = OfferMainVC(nibName: "OfferMainVC", bundle: bundle)
        let vc = offerVC!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.pushViewController(offerVC!, animated: true)
    }
    
    @IBAction func btnOpenOffers2_Click(_ sender: UIButton) {
        
//        let bundle = Bundle(for: type(of: self))
        
//        let colorsSetting = ColorSettings(primaryColor: UIColor.blue, secondaryColor: UIColor.yellow, primaryTextColor: UIColor.black, secondaryTextColor: UIColor.white, primaryButtonBGColor: UIColor.red, secondaryButtonBGColor: UIColor.black)

//        ThemeSettings.shared.colorSetting = ColorSettings.getDefaultTheme()
        ThemeSettings.shared.fontSetting = FontSettings.getDefaultFont()
        
        loadCustomConfiguration()
        
//        self.present(offerVC!, animated: true)
        
        
//        let frameworkBundleID  = "com.syw.OfferSDK";
//        let bundle = Bundle(identifier: frameworkBundleID)
//
//        let vc = OfferVC(nibName: "OfferVC", bundle: bundle)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        vc?.offerVC = offerVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
