//
//  ViewControllerBDA11.swift
//  Caridapp
//
//  Created by user190825 on 10/4/21.
//

import UIKit
import Foundation
//import CoreData

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewControllerBDA11: UIViewController {
    //let addImportation =
    let importationService = ImportationService()
    
    @IBAction func registrarAction(_ sender: Any) {
        
        if let nameP = nombreTF.text {
            if !nameP.isEmpty {
                let name = Importation(name: String(nameP))
            }
        }
        
    }
    
    @IBOutlet weak var nombreTF: UITextField!
    
    @IBOutlet weak var descripcionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            let controller = (segue.destination as! ImportationTableView)
            
            importationService.retrieveHistory() {
                (history) in
                DispatchQueue.main.async {
                    controller.history = history
                    controller.tableView.reloadData()
                }
            }
            
        }
    }
    

}// end of class
