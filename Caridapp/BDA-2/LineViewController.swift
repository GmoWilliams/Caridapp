//
//  LineViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//

extension UIViewController {
    func hideKeyboardWhenTappedAround2() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard2() {
        view.endEditing(true)
    }
}

import UIKit

class LineViewController: UIViewController {

    @IBOutlet weak var unitaryCostTF: UITextField!
    
    @IBOutlet weak var expirationTF: UITextField!
    
    @IBOutlet weak var quantityTF: UITextField!
    
    @IBOutlet weak var pickUpTF: UITextField!
    
    var lineZ:LineP?
    //var hero:HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        hola.text = lineZ?.itemName
        upcLbl.text = "UPC: \((lineZ?.upc)!)"
        unitaryCostLbl.text = "Unitary Cost: \((lineZ?.unitaryCost)!)"
        quantityLbl.text = "Quantity: \((lineZ?.quantity)!)"
        */
        
        unitaryCostTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        //expirationTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        quantityTF.placeholder = "\((lineZ?.quantity)!)"
        
        
 
        print("\((lineZ?.lineID)!)")
        print("\((lineZ?.donationID)!)")
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
