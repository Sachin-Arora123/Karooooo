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
    var db:DBHelper = DBHelper()
    
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
        db.insert(id: 0, username: self.username, password: self.password, country: self.country)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCountry{
            guard let countryListVC = storyboard?.instantiateViewController(withIdentifier: "CountryListVC") as? CountryListVC else{return false}
            countryListVC.countryList            = self.countryNameArray ?? []
            countryListVC.countryNameCallback = { country in
                self.country = country
                self.txtCountry.text = country
                
                self.countryErrorStackView.isHidden  = true
                self.countryOuterView.showRedBorder(false)
            }
            
            self.present(countryListVC, animated: true, completion: nil)
            
            return false
        }else{
            return true
        }
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

