//
//  WelcomeViewController.swift
//  Chatify
//
//  Created by Samed Karakuş on 24.08.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.titleLabel.text = ""
            var charIndex = 0.0
            let titleText = "Chatify"
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
            }
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

}
