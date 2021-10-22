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
    @IBOutlet weak var productWeight: UILabel!
    
    func updateCell(product: Product){
        productName.text = "Producto: " + product.itemName
        productDesc.text = "Descripcion: " + product.description
        productWeight.text = "Peso: " + String(product.unitaryWeight)
    }
}
