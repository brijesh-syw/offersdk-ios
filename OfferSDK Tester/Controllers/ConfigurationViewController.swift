//
//  ConfigurationViewController.swift
//  PYWTester
//
//  Created by Viacheslav Pryimachenko on 15.08.2022.
//

import UIKit
import OfferSDK

struct LocalConfiguration {
    let refId: String
    let merchantId: String
    let environment: OfferEnvironment
    let organization : String
    let programType : String
//    let isShowMemberNumber:Bool
//    let isShowMemberName:Bool
//    let isShowExpiringPoints:Bool
//    let sdkVersion: String
}

final class ConfigurationViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var accessTokenView: UIView!
    @IBOutlet private weak var accessTokenTextField: UITextField!
    
    @IBOutlet private weak var refIdView: UIView!
    @IBOutlet private weak var refIdTextField: UITextField!
    
    @IBOutlet private weak var merchantIdTextField: UITextField!
//    @IBOutlet private weak var payTypeTextField: UITextField!
    
    @IBOutlet private weak var programTypeTextField: UITextField!
    @IBOutlet private weak var clientIdentifierTextField: UITextField!
    @IBOutlet private weak var transactionIdTextField: UITextField!
    @IBOutlet private weak var memberNumberTextField: UITextField!
    @IBOutlet private weak var totalDueTextField: UITextField!
    @IBOutlet private weak var environmentSegmentControl: UISegmentedControl!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var handlerSwitch: UISwitch!
    @IBOutlet private weak var statusHandlerSwitch: UISwitch!
    @IBOutlet private weak var prepareButtonSwitch: UISwitch!
    
//    @IBOutlet private weak var sdkVersionTextField: UITextField!
    @IBOutlet private weak var organizationTextField: UITextField!
    
    
    @IBOutlet weak var showMemberNumberSwitch: UISwitch!
    @IBOutlet weak var showMemberNameSwitch: UISwitch!
    @IBOutlet weak var showExpiringPointsSwitch: UISwitch!
    @IBOutlet weak var contentHTMLTextView: UITextView!
    
    
    
    // MARK: - Properties
    
    var onSaveConfiguration: ((LocalConfiguration) -> Void)?
    var configuration: LocalConfiguration?
    
    private var isActionHandlerEnabled = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
    }
    
    // MARK: - Actions
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
//        guard
//            let merchantId = merchantIdTextField.text,
//            !merchantId.isEmpty,
//            let transactionId = transactionIdTextField.text,
//            !transactionId.isEmpty,
//            let totalDue = totalDueTextField.text,
//            !totalDue.isEmpty else {
//            self.showToast(message: "Not all required fields are filled")
//            return
//        }
//
        let environment: OfferEnvironment = environmentSegmentControl.selectedSegmentIndex == 0 ? .uat : .prod
//
        let configuration = LocalConfiguration(
            refId: refIdTextField.text ?? "",
            merchantId: merchantIdTextField.text ?? "",
            environment: environment,
//            isShowMemberNumber: showMemberNumberSwitch.isOn,
//            isShowMemberName: showMemberNameSwitch.isOn,
//            isShowExpiringPoints: showExpiringPointsSwitch.isOn,
            organization: organizationTextField.text ?? "",
            programType: programTypeTextField.text ?? ""
            
        )
//
//        if let mandatoryFieldText = environment == .uat ? accessTokenTextField.text : refIdTextField.text, mandatoryFieldText.isEmpty {
//            self.showToast(message: "Not all required fields are filled")
//            return
//        }
        
//        UserDefaults.standard.set(accessTokenTextField.text, forKey: "Access_token")
        UserDefaults.standard.set(refIdTextField.text, forKey: "refId")
        UserDefaults.standard.set(memberNumberTextField.text, forKey: "Member_Number")
//        UserDefaults.standard.set(totalDueTextField.text, forKey: "Total_Due")
        UserDefaults.standard.set(merchantIdTextField.text, forKey: "Merchant_Id")
        UserDefaults.standard.set(programTypeTextField.text, forKey: "program_type")
//        UserDefaults.standard.set(transactionIdTextField.text, forKey: "Transaction_Id")
        
//        UserDefaults.standard.set(showMemberNumberSwitch.isOn, forKey: "showMemberNumber")
//        UserDefaults.standard.set(showMemberNameSwitch.isOn, forKey: "showMemberName")
//        UserDefaults.standard.set(showExpiringPointsSwitch.isOn, forKey: "showExpiringPoints")
//        UserDefaults.standard.set(contentHTMLTextView.text, forKey: "contentHTML")
        UserDefaults.standard.set(organizationTextField.text, forKey: "organization")
        
        
        onSaveConfiguration?(configuration)
        dismiss(animated: true)
    }
    
    @IBAction private func segmentValueChanged(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            refIdView.isHidden = true
//            refIdTextField.text = nil
//            accessTokenView.isHidden = false
//            merchantIdTextField.text = "TELL_PYW_UNIMNY_UAT"
//        } else if sender.selectedSegmentIndex == 1 {
//            refIdView.isHidden = false
//            accessTokenView.isHidden = true
//            accessTokenTextField.text = nil
//            merchantIdTextField.text = "TELLURIDESTRESS"
//        }
    }
    
    @objc private func handleCloseButtonTap() {
        dismiss(animated: true)
    }
}

private extension ConfigurationViewController {
    func setupUi() {
        setupTextField(textField: accessTokenTextField)
        setupTextField(textField: refIdTextField)
        setupTextField(textField: merchantIdTextField)
        setupTextField(textField: programTypeTextField)
//        setupTextField(textField: transactionIdTextField)
//        setupTextField(textField: totalDueTextField)
//        setupTextField(textField: payTypeTextField)
        setupTextField(textField: organizationTextField)
        
        contentHTMLTextView.layer.cornerRadius = 8
        contentHTMLTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        contentHTMLTextView.layer.borderWidth = 0.5
        
        
        saveButton.backgroundColor = .blue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        
        setupNavigationItems()
        
        guard let configuration = configuration else {
            setupDefaultValues()
            return
        }
        
        setConfiguration(config: configuration)
    }
    
    func setupTextField(textField: UITextField) {
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
    }
    
    func setupDefaultValues() {
        merchantIdTextField.text = UserDefaults.standard.string(forKey: "Merchant_Id")
        programTypeTextField.text = UserDefaults.standard.string(forKey: "program_type")
//        transactionIdTextField.text = "10004"
//        transactionIdTextField.text = UserDefaults.standard.string(forKey: "Transaction_Id") ?? "10004"
//        totalDueTextField.text = Constants.totalDue
//        accessTokenTextField.text = UserDefaults.standard.string(forKey: "Access_token")
        memberNumberTextField.text = UserDefaults.standard.string(forKey: "Member_Number")
//        totalDueTextField.text = UserDefaults.standard.string(forKey: "Total_Due")
        refIdTextField.text = UserDefaults.standard.string(forKey: "refId")
        environmentSegmentControl.selectedSegmentIndex = 0
//        handlerSwitch.setOn(false, animated: true)
//        statusHandlerSwitch.setOn(false, animated: true)
//        prepareButtonSwitch.setOn(true, animated: true)
        
        organizationTextField.text = UserDefaults.standard.string(forKey: "organization")
//
//        showMemberNumberSwitch.setOn(true, animated: true)
//        showMemberNameSwitch.setOn(true, animated: true)
//        showExpiringPointsSwitch.setOn(true, animated: true)
        
        
//        UserDefaults.standard.bool(forKey: "showMemberNumber")
        
//        contentHTMLTextView.text = ""
        //UserDefaults.standard.string(forKey: "contentHTML")
        
        
//
        refIdView.isHidden = false
        accessTokenView.isHidden = true
        
        
    }
    
    func setConfiguration(config: LocalConfiguration) {
//        merchantIdTextField.text = config.merchantId
//        transactionIdTextField.text = config.transactionId
//        totalDueTextField.text = config.totalDue
//        accessTokenTextField.text = config.accessToken
//        environmentSegmentControl.selectedSegmentIndex = config.environment == .uat ? 0 : 1
//        handlerSwitch.setOn(config.prepareHandler, animated: true)
//        statusHandlerSwitch.setOn(config.statusHandler, animated: true)
//        prepareButtonSwitch.setOn(config.isPrepareButtonEnabled, animated: true)
//        payTypeTextField.text = config.payType
//        clientIdentifierTextField.text = config.clientIdentifier
//
//        refIdView.isHidden = config.environment == .uat
//        accessTokenView.isHidden = config.environment != .uat
        
        merchantIdTextField.text = config.merchantId
        programTypeTextField.text = config.programType
//        memberNumberTextField.text = config.memberNumber
        refIdTextField.text = config.refId
        
       
//        showMemberNumberSwitch.setOn(config.isShowMemberNumber, animated: true)
//        showMemberNameSwitch.setOn(config.isShowMemberName, animated: true)
//        showExpiringPointsSwitch.setOn(config.isShowExpiringPoints, animated: true)
        organizationTextField.text = config.organization
        
//        contentHTMLTextView.text = UserDefaults.standard.string(forKey: "contentHTML")
        
    }
    
    func setupNavigationItems() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleCloseButtonTap))
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.title = "Edit configuration"
    }
}

extension ConfigurationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
