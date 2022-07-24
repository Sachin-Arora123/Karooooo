//
//  LoginVC.swift
//  Karooooo
//
//  Created by Sachin on 23/07/22.
//

import UIKit

final class LoginVC: UIViewController {

    // MARK: - Outlets and variables
    //text fields
    @IBOutlet private weak var txtUsername: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    
    //textField outerViews
    @IBOutlet private weak var usernameOuterView: SCView!
    @IBOutlet private weak var passwordOuterView: SCView!
    @IBOutlet weak var countryOuterView: SCView!
    
    //error stack views
    @IBOutlet private weak var usernameErrorStackView: UIStackView!
    @IBOutlet private weak var passwordErrorStackView: UIStackView!
    @IBOutlet weak var countryErrorStackView: UIStackView!
    
    //labels to show validation errors
    @IBOutlet private weak var lblUsernameError: UILabel!
    @IBOutlet private weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblCountryError: UILabel!
    
    //Login Button
    @IBOutlet private weak var btnLogin: SCButton!
    
    private var username = ""
    private var password = ""
    private var country  = ""
    var countryNameArray : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView(){
        //setup navigation bar
        self.title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //initial state
        btnLogin.isEnabled              = false
        usernameErrorStackView.isHidden = true
        passwordErrorStackView.isHidden = true
        countryErrorStackView.isHidden  = true
        
        self.countryNameArray = NSLocale.getCountryNames()
    }
   
    @IBAction func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        //check if user has selected any country.
        self.view.endEditing(true)
        if self.country == ""{
            countryErrorStackView.isHidden  = false
            lblCountryError.text = "Please select your country"
            countryOuterView.showRedBorder(true)
        }else{
            //Proceed with saving the data in database.
            saveData()
        }
    }
    
    // Save data in database
    func saveData(){
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
//            self.present(successFail urePopup, animated: true, completion: nil)
//        })
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCountry{
            guard let countryListVC = storyboard?.instantiateViewController(withIdentifier: "CountryListVC") as? CountryListVC else{return false}
//            countryListVC.modalPresentationStyle = .fullScreen
            countryListVC.countryList            = self.countryNameArray ?? []
//            searchLocationVC.locationCallback = { returnedPlacemark in
//                self.searchedCoordinates = returnedPlacemark.coordinate
//
//                searchBar.text = returnedPlacemark.name
//
//                //hit the search api and refresh the map with new cluster items.
//                self.getClusterItems(isSilent: false)
//            }
            
            self.present(countryListVC, animated: true, completion: nil)
        }
        
        return false
    }
    
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
            if !textField.text!.isValidPassword{
                passwordOuterView.showRedBorder(true)
                passwordErrorStackView.isHidden = false
                lblPasswordError.text           = "Please enter a valid password"
            }
        }
    }
    
    func checkAvailability(){
        if (self.username != "") && (self.password != "") && self.password.isValidPassword{
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = .appGreenColor
        }else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = .appGreenColorDisabled
        }
    }
}

