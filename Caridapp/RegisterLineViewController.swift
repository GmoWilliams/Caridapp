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
    var upc : Int64 = 750105530007;
    var name : String = "Coca-Cola";
    var donation : Donation?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("upc selected: /(upc)")
    }

    @IBAction func savingLine(_ sender: Any) {
        guard let cost = Float(self.unitaryCost.text!) else {print("Escriba el costo por favor"); return;}
        let date = self.expirationDate.date as Date;
        guard let quantityProduct = Int(self.quantity.text!) else { print("No hay cantidad"); return;}
        
        let data = Line(upc: upc, cost: cost, expirationDate: date, orQuantity: quantityProduct, quantity: quantityProduct, name: name);
        
        donation?.addLine(line: data);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lineAdded" {
            let controller = (segue.destination as! ViewControllerBDA11)
            
            DispatchQueue.main.async {
                controller.donation = self.donation;
            }
        }
    }
}
