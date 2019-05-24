//
//  Appeal.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import RealmSwift

class Appeal : Object{
    
    @objc dynamic var message : String = ""
    @objc dynamic var sender : String = ""
    @objc dynamic var type : String = ""
    @objc dynamic var dateCreated: Date?
}
