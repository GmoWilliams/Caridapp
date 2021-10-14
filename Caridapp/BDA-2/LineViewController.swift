//
//  LineViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//

import UIKit

class LineViewController: UIViewController {

    @IBOutlet weak var hola: UILabel!
    
    @IBOutlet weak var upcLbl: UILabel!
    
    @IBOutlet weak var donationIDLbl: UILabel!
    
    @IBOutlet weak var unitaryCostLbl: UILabel!
    
    @IBOutlet weak var productExpirationLbl: UILabel!
    
    @IBOutlet weak var originalQuantityLbl: UILabel!
    
    @IBOutlet weak var quantityLbl: UILabel!
    
    var lineZ:LineP?
    var hero:HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hola.text = lineZ?.itemName
        upcLbl.text = "UPC: \((lineZ?.upc)!)"
        unitaryCostLbl.text = "Unitary Cost: \((lineZ?.unitaryCost)!)"
        quantityLbl.text = "Quantity: \((lineZ?.quantity)!)"
        
        print("\((lineZ?.itemName)!)")
        print("\((lineZ?.upc)!)")
        print("\((lineZ?.quantity)!)")
        print("\((lineZ?.originalQuantity)!)")
        print("\((lineZ?.unitaryCost)!)")
    }
    
    /*
    let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
    */

}
