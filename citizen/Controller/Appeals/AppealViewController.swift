//
//  AppealViewController.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit

class AppealViewController : UIViewController{
    var text : String?
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var texLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(text)
        if text == nil {
            print("kek")
        }
        else {
            texLabel.text = text
        }
    }
}
