//
//  LoginVC.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Outlets and variables
    //text fields
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //textField outerViews
    @IBOutlet weak var usernameOuterView: SCView!
    @IBOutlet weak var passwordOuterView: SCView!
    
    //error stack views
    @IBOutlet weak var usernameErrorStackView: UIStackView!
    @IBOutlet weak var passwordErrorStackView: UIStackView!
    
    //labels to show validation errors
    @IBOutlet weak var lblUsernameError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    //Login Button
    @IBOutlet weak var btnLogin: SCButton!
    
    
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
//        for countryName in NSLocale.getCountryNames() {
//            print("\(countryName)")
//        }
    }
    
    func setupView(){
        //setup navigation bar
        self.title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //initial state
        btnLogin.isEnabled              = false
        usernameErrorStackView.isHidden = true
        passwordErrorStackView.isHidden = true
    }
   
    @IBAction func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        //User register api.
//        sender.loadingIndicator(true, sender.titleLabel?.text ?? "")
//        guard let params = GetParamModel.shared.getLoginParam(self.email, self.password) else{return}
//        self.loginApi(params)
    }
    
    // Login api
    func loginApi(_ parameters:[String:Any]){
//        let apiurl = ConstantModel.shared.api.login
//        ApiCallModel.shared.apiCall(isSilent: true, url:apiurl, parameters: parameters, type: ConstantModel.shared.api.PostAPI, delegate: self, success: { response in
//            self.btnLogin.loadingIndicator(false, self.btnLogin.titleLabel?.text ?? "")
//            //parse the data and save the profile model.
//            APIResponseModel.shared.parseLoginResponse(response: response, sender: self) { result in
//                let name = UserDefaultsHandler.userInfo!.firstName + " " + UserDefaultsHandler.userInfo!.lastName
//
//                FirebaseOperationModel.shared.registerUser(UserDefaultsHandler.userInfo!.id, values: ["name": name,
//                "email": UserDefaultsHandler.userInfo?.email ?? "",
//                "token": UserDefaultsHandler.deviceToken ?? "",
//                "isOnline": true] as [String: Any])
//
//                //check if the email is confirmed or not.
//                if let confirmStatus = UserDefaultsHandler.emailConfirmed{
//                    if confirmStatus{
//                        //move to dashboard
//                        UserDefaultsHandler.pageToShow = ConstantModel.shared.page.TabScreen
//                        NavigationManager.shared.checkWhereToNav(3, nil)
//                    }else{
//                        //redirect to email verification information screen.
//                        guard let emailVerificationInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "EmailVerificationInfoVC") as? EmailVerificationInfoVC else{return}
//                        emailVerificationInfoVC.email      = self.email
//                        emailVerificationInfoVC.isComeFrom = "Login"
//                        UserDefaultsHandler.isVerificationCompleted = false
//                        self.navigationController?.pushViewController(emailVerificationInfoVC, animated: true)
//                    }
//                }
//            }
//        }, failure: { error in
//            self.btnLogin.loadingIndicator(false, self.btnLogin.titleLabel?.text ?? "")
//            let storyboard = UIStoryboard(name: "PublishParkingSlot", bundle: nil)
//            guard let successFailurePopup = storyboard.instantiateViewController(withIdentifier: "SuccessFailurePopup") as? SuccessFailurePopup else{return}
//            successFailurePopup.isSuccess = false
//            successFailurePopup.successFailureText = "Felaktig e-postadress eller lösenord"
//            self.present(successFailurePopup, animated: true, completion: nil)
//        })
    }
}

extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //This is mainly for shifting the responder
        if textField == txtUsername{
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            self.view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if textField == txtUsername {
            usernameOuterView.showRedBorder(false)
            usernameErrorStackView.isHidden = true
            self.username = currentText
        }else if textField == txtPassword {
            passwordOuterView.showRedBorder(false)
            passwordErrorStackView.isHidden = true
            self.password = currentText
        }
        
        checkAvailability()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtUsername, textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            usernameOuterView.showRedBorder(true)
            usernameErrorStackView.isHidden = false
            lblUsernameError.text           = "Please enter username"
        }else if textField == txtPassword, textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            passwordOuterView.showRedBorder(true)
            passwordErrorStackView.isHidden = false
            lblPasswordError.text           = "Please enter password"
        }else if textField == txtPassword, textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            if !textField.text!.isValidPassword(){
                passwordOuterView.showRedBorder(true)
                passwordErrorStackView.isHidden = false
                lblPasswordError.text           = "Please enter a valid password"
            }
        }
    }
    
    func checkAvailability(){
        if (self.username != "") && (self.password != "") && self.password.isValidPassword(){
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = UIColor.appGreenColor()
        }else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = UIColor.appGreenColorDisabled()
        }
    }
}



extension NSLocale {
    //get an array of country names from NSlocale
    class func getCountryNames() -> [String] {
        var countryNames = [String]()
        for localeCode in NSLocale.isoCountryCodes {
            let countryName = (NSLocale.current as NSLocale).displayName(forKey: .countryCode, value: localeCode) ?? ""
            countryNames.append(countryName)
        }
        return countryNames
    }

}

