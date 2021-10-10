//
//  ViewController.swift
//  Caridapp
//
//  Created by user190825 on 9/9/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addImportation" {
            let controller = (segue.destination as! RegisterNewViewController)
            
            DispatchQueue.main.async {
                controller.donation = Donation(status: nil, receptionDate: nil, pickUpDate: nil, warehouse: nil)
            }
        }
    }

}

