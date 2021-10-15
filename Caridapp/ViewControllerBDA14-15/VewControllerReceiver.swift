//
//  VewControllerReceiver.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

class ViewControllerReceiver: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        self.hideKeyboardWhenTappedAround()
    }


    

    @IBOutlet var ReceiverDonationInfo: UILabel!
    @IBAction func goToBDA14_2(_ sender: Any) {
        performSegue(withIdentifier: "SegueBDA14", sender: self)
    }
}
