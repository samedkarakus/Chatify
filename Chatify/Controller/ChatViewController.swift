//
//  ChatViewController.swift
//  Chatify
//
//  Created by Samed Karakuş on 24.08.2024.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [
        Message(sender: "Melike", body: "You know, as we’ve been talking about our future together lately, I can’t help but feel excited about the possibilities, especially when I think about building a life with you, traveling to new places, and maybe even starting a family one day."),
        Message(sender: "Samed", body: "I love the idea of exploring the world together, but I also think it’s important for us to take our time and make sure we’re both ready for those big steps, like finding the right place to settle down and really figuring out our careers."),
        Message(sender: "Melike", body: "Absolutely, and while I dream about having a home filled with love and laughter, I also want us to keep nurturing our individual passions and support each other in achieving our personal goals along the way.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = Constants.messageReceiver
        UIUpdate()
        messageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
//MARK: - UI Changes
    
    func textFieldChanged(_ textField: UITextField) {
        let borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = borderColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 15.0
    }

    
    func placeHolderColorChanged(_ placeHolderTextField: UITextField, placeHolder: String) {
        placeHolderTextField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    func tableViewUIUpdate() {
        tableView.backgroundColor = UIColor.clear
    }
    
    func UIUpdate() {
        textFieldChanged(messageTextField)
        placeHolderColorChanged(messageTextField, placeHolder: "Type a message...")
        tableViewUIUpdate()
    }
    
    @objc func textFieldDidChange() {
        if let text = messageTextField.text, !text.isEmpty {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
}


//MARK: - Table View Data Source Extension

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResuableCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
}
