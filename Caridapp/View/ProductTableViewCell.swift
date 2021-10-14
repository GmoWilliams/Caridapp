//
//  ProductTableViewCell.swift
//  Caridapp
//
//  Created by user194082 on 10/9/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    func updateCell(product: Product){
        productName.text = String(product.itemName)
        productDesc.text = String(product.description)
    }
}
