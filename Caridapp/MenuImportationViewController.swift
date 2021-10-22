//
//  MenuImportationViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/10/21.
//

import UIKit

class MenuImportationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addImportation" {
            let controller = (segue.destination as! ViewControllerBDA11)
            let donation = Donation(status: nil, receptionDate: nil, pickUpDate: nil, warehouse: nil)
            //donation.addLine(line: Line(upc: 750105530007, cost: 50.50, expirationDate: Date(), orQuantity: 6, quantity: 5, name: "Coca-Cola"))
            
            DispatchQueue.main.async {
                controller.donation = donation
            }
        }
    }

}