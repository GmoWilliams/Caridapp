//
//  ProductTableViewCell.swift
//  Caridapp
//
//  Created by user194082 on 10/9/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    func updateCell(product: Product){
        productName.text = product.itemName
        productDesc.text = product.description
    }
}
