//
//  AddAppeal.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

class AddAppealViewController : UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    let newTypes = [ "Неухоженный двор", "Мусор в лесу", "Брошеная машина", "Выбросы в атмосферу", "Грязь на улице", "Яма на дороге", "Неисправное освещение", "Незаконная реклама", "Заполненная мусорка"]
    var appealType : Int?
    
    var alert: UIAlertController!
    var yes: UIAlertAction!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
        textView.endEditing(true)
        
        let appealDB = Database.database().reference().child("appeals")
        if let text = textView.text, text != "" {
            let appeal = Appeal()
            fillAppeal(appeal : appeal)
            updateRealm(appeal: appeal)
            
            let appealDictionary : [String:Any] = ["Sender" : Auth.auth().currentUser?.email,"text" : text, "type" : "\(appealType!)"]
            appealDB.childByAutoId().setValue(appealDictionary) {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("uploaded")
                }
            }
            
            navigationController?.popViewController(animated: true)
        }
        else {
            present(alert, animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        createAlert()
        //HideKeyobard()
    }
    
    func fillAppeal(appeal : Appeal) {
        appeal.message = textView.text
        appeal.sender = (Auth.auth().currentUser?.email)!
        appeal.type = "\(appealType!)"
        appeal.dateCreated = Date()
    }
    
    func createAlert() {
        alert = UIAlertController(title: "Ошибка", message: "Поле ввода нельзя оставлять пустым!", preferredStyle: .alert)
        yes = UIAlertAction(title: "Понятно.", style: .default) { _ in self.dismiss(animated: true, completion: nil) }
        alert.addAction(yes)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func HideKeyobard() {
        let Tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func updateRealm(appeal : Appeal) {
        try! realm.write {
            realm.add(appeal)
        }
    }
    
}

