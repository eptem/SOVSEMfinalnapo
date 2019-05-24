//
//  RegisterViewController.swift
//  citizen
//
//  Created by Артем Жорницкий on 05/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rgsrtButton: UIButton!
    
    
    
    
    @IBAction func registrTapped(_ sender: Any) {
        if let login = loginTextfield.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: login, password: password) { (user, error) in
                
                if error != nil {
                    print(error!)
                    self.createAlert()
                }
                else {
                    self.changeRoot()
                    print("user registrated")
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.loginTextfield.delegate = self
        self.passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextfield.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 35.0
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func changeRoot() {
        let tabBar = UITabBarController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let optionsVC = storyboard.instantiateViewController(withIdentifier: "options")
        let chooseVC = storyboard.instantiateViewController(withIdentifier: "choose")
        let showVC = storyboard.instantiateViewController(withIdentifier: "show")
        let firstNC = UINavigationController(rootViewController: optionsVC)
        let secondNC = UINavigationController(rootViewController: chooseVC)
        let thirdNC = UINavigationController(rootViewController: showVC)
        var tabBarControllers : [UIViewController] {
            return [secondNC, thirdNC, firstNC]
        }
        tabBar.viewControllers = tabBarControllers
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = tabBar
        window??.makeKeyAndVisible()
    }
    
    func createAlert() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Введенные данные некорректны", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Понятно", style: .cancel)
        
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
}
