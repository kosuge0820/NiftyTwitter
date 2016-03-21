//
//  LoginViewController.swift
//  NiftyTwitter
//
//  Created by 小菅仁士 on 2016/03/20.
//  Copyright © 2016年 kosuge satoshi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func tapLoginButton(sender: UIButton) {
        let user = User(name: nameTextField.text!, password: passwordTextField.text!)
        user.login { (message) in
            if let unwrappedMessage = message {
                self.showAlert(unwrappedMessage)
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func tapSignUpButton(sender: UIButton) {
        let user = User(name: nameTextField.text!, password: passwordTextField.text!)
        user.signUp { (message) -> Void in
            if let unwrappedMessage = message {
                self.showAlert(unwrappedMessage)
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
