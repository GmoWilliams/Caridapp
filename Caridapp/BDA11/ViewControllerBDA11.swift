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
    //let importationService = ImportationService()
    
    @IBAction func registrarAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Registrar Datos", message: "Se enviara la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            guard let nameP = self.nombreTF.text else {print("Hace falta el nombre"); return}
            guard let descP = self.descripcionTF.text else {print("Hace falta la descripcion"); return}
            
            let datos = Importation(name: nameP, desc: descP)
            print (datos)
            let postRequest = APIRequest(endpoint: "import")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Nombre del producto: \(datos.name)\n Descripcion: \(datos.desc)")
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })
        }))
        self.present(alert, animated: true)
        /*if let nameP = nombreTF.text {
            if !nameP.isEmpty {
                let name = Importation(name: String(nameP))
            }
        }*/
        
    }
    
    @IBOutlet weak var nombreTF: UITextField!
    
    @IBOutlet weak var descripcionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }*/
    

}// end of class
