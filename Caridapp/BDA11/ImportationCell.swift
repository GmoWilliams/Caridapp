//
//  ImportationCell.swift
//  Caridapp
//
//  Created by user190825 on 10/4/21.
//

import Foundation
import UIKit

class ImportationCell: UITableViewCell
{
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    func updateCell(importation: Importation){
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "YYYY-MM-dd"
        nombreLabel.text = String(importation.name)
        descripcionLabel.text = String(importation.desc)
    }
}

