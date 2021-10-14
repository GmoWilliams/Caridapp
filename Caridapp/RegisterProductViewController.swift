//
//  RegisterProductViewController.swift
//  Caridapp
//
//  Created by user190825 on 9/9/21.
//


import UIKit

class RegisterProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var donation : Donation?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectProduct" {
            let controller = (segue.destination as! SelectProductViewController)
            
            DispatchQueue.main.async {
                controller.donation = self.donation;
            }
        }
    }


}
