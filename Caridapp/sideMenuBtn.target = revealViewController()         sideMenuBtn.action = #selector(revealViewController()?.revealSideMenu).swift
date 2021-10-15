//
//  MenuImportationViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/10/21.
//

import UIKit

class MenuImportationViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addImportation" {
//            let controller = (segue.destination as! RegisterProductViewController)
//
//            DispatchQueue.main.async {
//                controller.donation = Donation(status: nil, receptionDate: nil, pickUpDate: nil, warehouse: nil)
//            }
//        }
//    }

}
