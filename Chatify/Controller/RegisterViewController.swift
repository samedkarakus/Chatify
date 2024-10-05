//
//  RegisterViewController.swift
//  Chatify
//
//  Created by Samed Karakuş on 24.08.2024.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginRegisterViewLayout(registerView)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Successfully registered.")
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
    
    
    
    
//MARK: - UI Changes
    
    func textFieldChanged(_ textField: UIView) {
        let borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = borderColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
    }
    
    func placeHolderColorChanged(_ placeHolderTextField: UITextField, placeHolder: String) {
        placeHolderTextField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
    
    func loginRegisterViewLayout(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        textFieldChanged(emailTextField)
        textFieldChanged(passwordTextField)
        placeHolderColorChanged(emailTextField, placeHolder: "Email")
        placeHolderColorChanged(passwordTextField, placeHolder: "Password")
    }
}

