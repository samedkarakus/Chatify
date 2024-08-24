//
//  RegisterViewController.swift
//  Chatify
//
//  Created by Samed Karakuş on 24.08.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var isKeyboardVisible = false
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.layer.cornerRadius = 25
        registerView.clipsToBounds = true
        textFieldChanged(emailTextField)
        textFieldChanged(passwordTextField)
        placeHolderColorChanged(emailTextField, placeHolder: "Email")
        placeHolderColorChanged(passwordTextField, placeHolder: "Password")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
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

    @objc func keyboardWillShow(notification: NSNotification) {
        guard !isKeyboardVisible else { return }

        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let keyboardHeight = keyboardFrame.height
            
            let textFieldYPosition = registerView.frame.origin.y
            let offset = textFieldYPosition - (self.view.frame.height - keyboardHeight - registerView.frame.height - 10)
            
            if offset > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.registerView.transform = CGAffineTransform(translationX: 0, y: -offset)
                }
            }
            isKeyboardVisible = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.registerView.transform = .identity
        }
        isKeyboardVisible = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
