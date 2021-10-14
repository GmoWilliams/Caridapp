//
//  VewControllerReceiver.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

class ViewControllerReceiver: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    @IBOutlet var ReceiverDonationInfo: UILabel!
    @IBAction func goToBDA14_2(_ sender: Any) {
        performSegue(withIdentifier: "SegueBDA14", sender: self)
    }
}
