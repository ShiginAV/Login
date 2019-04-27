//
//  LoginViewController.swift
//  Login
//
//  Created by Alexander on 25/04/2019.
//  Copyright © 2019 Alexander Shigin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewVerticallyConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.size.height)
        userNameTextField.delegate = self
        passwordTextField.delegate = self

        self.addKeyboardObserver()
        self.hideKeyboard()
    }
}

// MARK: - Navigation
extension LoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultViewController = segue.destination as? ResultViewController else { return }
        
        if userNameTextField.text == kUserName, passwordTextField.text == kPassword {
            resultViewController.resultLabelTextString = "Hello \(kUserName)"
        } else {
            resultViewController.resultLabelTextString = "Wrong user name or password"
        }
    }
}

//MARK: - Actions
extension LoginViewController {
    @IBAction func actionLoginBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToResultViewController", sender: self)
    }
    
    @IBAction func actionFogotBtns(_ sender: UIButton) {
        guard let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return }
        
        present(resultViewController, animated: true, completion: nil)
        resultViewController.resultLabel.text = self.getTextBy(button: sender)
    }
    
    func getTextBy(button: UIButton) -> String {
        var text = ""
        switch button.tag {
        case ButtonTag.fogotUserNameBtn.rawValue:
            text = "User name: \(kUserName)"
        case ButtonTag.fogotPasswordBtn.rawValue:
            text = "Password: \(kPassword)"
        default: break
        }
        return text
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "segueToResultViewController", sender: self)
        return true
    }
}

//MARK: - Keyboard
extension LoginViewController {
    func addKeyboardObserver() {
        let names = [UIResponder.keyboardWillShowNotification, UIResponder.keyboardDidHideNotification]
        for name in names {
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: name, object: nil)
        }
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] else { return }
        guard let keyboardFrameValue = keyboardFrame as? NSValue else { return }
        
        let keyboardSize = keyboardFrameValue.cgRectValue
        let constant: CGFloat
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            if view.frame.size.height <= 320 {
                constant = (view.frame.size.height / 2 - keyboardSize.height) - stackView.frame.size.height / 4
            } else {
                constant = (view.frame.size.height / 2 - keyboardSize.height) - stackView.frame.size.height / 2
            }
        } else {
            constant = 0
        }
        stackViewVerticallyConstraint.constant = constant
    }
    
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
