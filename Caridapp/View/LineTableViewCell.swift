//
//  lineTableViewCell.swift
//  Caridapp
//
//  Created by user194082 on 10/14/21.
//

import UIKit

class LineTableViewCell: UITableViewCell {
    @IBOutlet weak var lineNameField: UILabel!
    @IBOutlet weak var quantityField: UILabel!
    @IBOutlet weak var costField: UILabel!
    @IBOutlet weak var expirationField: UILabel!
    
    func updateCell(line: Line){
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        
        lineNameField.text = line.name;
        quantityField.text = String(line.quantity);
        costField.text = String(line.unitaryCost);
        expirationField.text = dateFormatter.string(from: line.expirationDate);
    }
}
