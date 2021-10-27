//
//  RegisterLineViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/14/21.
//

import UIKit

class RegisterLineViewController: UIViewController {
    
    let donationService = DonationService()
    
    @IBOutlet weak var unitaryCost: UITextField!
    @IBOutlet weak var expirationDate: UIDatePicker!
    @IBOutlet weak var quantity: UITextField!
    var donation : Donation? {
        didSet {
            
        }
    }
    var product: Product? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        //print("upc selected: \(product!.upc)")
        //print("name of the product: \(product!.itemName)")
    }

    @IBAction func savingLine(_ sender: Any) {
        guard let cost = Float(self.unitaryCost.text!) else {print("Escriba el costo por favor"); return;}
        let date = self.expirationDate.date as Date;
        guard let quantityProduct = Int(self.quantity.text!) else { print("No hay cantidad"); return;}
        
        let data = Line(upc: product!.upc, cost: cost, expirationDate: date, orQuantity: quantityProduct, quantity: quantityProduct, name: product!.itemName);
        
        donation?.addLine(line: data);
        
        DispatchQueue.main.async(){
            let vc = self.storyboard?.instantiateViewController(identifier: "BDA-11ID") as! ViewControllerBDA11
            self.navigationController?.pushViewController(vc, animated: true)
            vc.donation = self.donation;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async(){
            let vc = self.storyboard?.instantiateViewController(identifier: "BDA-11ID") as! ViewControllerBDA11
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
