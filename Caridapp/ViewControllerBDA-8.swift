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

class ViewControllerBDA8: UIViewController {
    
    //let importationService = ImportationService()
    @IBAction func registratAction(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "Registrar Datos", message: "Se enviara la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            guard let nameD = self.NameD.text else {print("Hace falta el nombre"); return}
            guard let adsF = self.AddressF.text else {print("Hace falta la descripcion"); return}
            guard let adsR = self.AddressR.text else {print("Hace falta el upc"); return}
            guard let rfc = self.Rfc.text else {print("Hace falta el peso"); return}
            guard let phone = self.Phone.text else {print("Hace falta el peso"); return}
            guard let email = self.Email.text else {print("Hace falta el peso"); return}
            
            let datos = Donator(name: nameD, addressF: adsF, addressR: adsR, rfc: rfc, phone: phone, email: email)
            
            let postRequest = APIRequest(endpoint: "import")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n Nombre del producto: \(datos.itemName)\n Descripcion: \(datos.description)\n UPC: \(datos.upc)\n Peso: \(datos.unitaryWeight)")
                    
                    DispatchQueue.main.async(){
                       self.performSegue(withIdentifier: "AddingProduct", sender: self)
                    }
                    
                
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })
        }))
        
        
        
        self.present(alert, animated: true)
        
    }
    
    
    @IBOutlet weak var Rfc: UITextField!
    @IBOutlet weak var NameD: UITextField!
    
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var AddressF: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var AddressR: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    var donation : Donation?
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // if segue.identifier == "selectProduct" {
         //   let controller = (segue.destination as! Registrar)
           //
           // DispatchQueue.main.async {
            //    controller.donation = self.donation;
            //}
       // }
    //
    

}// end of class
