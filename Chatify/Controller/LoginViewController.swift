//
//  ViewController.swift
//  Chatify
//
//  Created by Samed Karakuş on 24.08.2024.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginRegisterViewLayout(loginView)
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Successfully logged in.")
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
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

