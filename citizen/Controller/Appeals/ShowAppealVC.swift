//
//  ShowAppealVC.swift
//  citizen
//
//  Created by Артем Жорницкий on 22/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class ShowAppealVC : UIViewController {
    
    var imgArray = ["dvor", "les", "car", "vibros", "gorod", "road", "svet", "reklama", "trash"]
    let newTypes = [ "Неухоженный двор", "Мусор в лесу", "Брошеная машина", "Выбросы в атмосферу", "Грязь на улице", "Яма на дороге", "Неисправное освещение", "Незаконная реклама", "Заполненная мусорка"]
    
    var appeals : Results<Appeal>!
    
    let realm  = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        readData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        readData()
    }
}

extension ShowAppealVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appeals.count == 0 {
            return 1
        }
        else {
            return appeals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCell
        if appeals.count == 0 {
            cell.typeLabel.text = "Запишите первое обращение"
            cell.dateLabel.isHidden = true
        }
        else {
            cell.dateLabel.isHidden = false
            cell.typeLabel.text = newTypes[Int(appeals[indexPath.row].type)!]
            cell.img.image = UIImage(named: imgArray[Int(appeals[indexPath.row].type)!])
            cell.dateLabel.text = getDate(date: appeals[indexPath.row].dateCreated!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if appeals.count > 0 {
            let vc =  AppealViewController.instance() as! AppealViewController
            vc.text = appeals[indexPath.row].message
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func getDate(date : Date) -> String {
        var strDate : String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm   dd.MM.yy"
        strDate = "Отправлено в \(formatter.string(from: date))"
        return strDate
    }
    
    func readData() {
        appeals = realm.objects(Appeal.self)
        tableView.reloadData()
    }
}

