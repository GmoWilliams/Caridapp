//
//  ImportationTableView.swift
//  Caridapp
//
//  Created by user190825 on 10/4/21.
//

import Foundation
import UIKit

//var importationList = [Importation]()

class ImportationTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var history : [Importation]? {
                didSet {
                }
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ImportationCellID", for: indexPath) as? ImportationCell {
                        let importa = history?[indexPath.row]
                        cell.updateCell(importation: importa!)
                        return cell
        }

                    return UITableViewCell()
    }
}

