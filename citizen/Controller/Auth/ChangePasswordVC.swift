//
//  ChangePasswordVC.swift
//  citizen
//
//  Created by Артем Жорницкий on 22/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChangePasswordVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstPassword: UITextField!
    @IBOutlet weak var secondPassword: UITextField!
    
    @IBOutlet weak var stateLabel: UILabel! {
        didSet {
            stateLabel.text = "Хотите изменить пароль?"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.firstPassword.delegate = self
        self.secondPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if let first = firstPassword.text, let second = secondPassword.text {
            if first == second, first != "", second != "" {
                Auth.auth().currentUser?.updatePassword(to : first)
                stateLabel.textColor = UIColor.green
                stateLabel.text = "Пароль успешно изменен!"
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                createAlert()
                stateLabel.textColor = UIColor.red
                stateLabel.text = "Введенные пароли не совпадают!"
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstPassword.resignFirstResponder()
        secondPassword.resignFirstResponder()
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
    
    func createAlert() {
        
        let alert = UIAlertController(title: "Ошибка.", message: "Введенные данные некорректны.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Понятно.", style: .cancel)
        
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
}


