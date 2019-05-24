//
//  MainNavigationController.swift
//  citizen
//
//  Created by Артем Жорницкий on 21/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import UIKit
import Firebase

class MainNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        present(LogInViewController(), animated: true)
    }
}
