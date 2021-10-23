//
//  ViewControllerBDA11.swift
//  Caridapp
//
//  Created by user190825 on 10/4/21.
//
import UIKit
import Foundation

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
    
    let importationService = DonationService()
    
    // MARK: - REGISTRAR BUTTON
    @IBAction func registratAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Registrar Datos", message: "Se enviara la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            // We make sure that all textfields are filled
            guard let nameP = self.nombreTF.text else {print("Hace falta el nombre"); return}
            guard let descP = self.descripcionTF.text else {print("Hace falta la descripcion"); return}
            guard let upcT = self.upcTF.text, let upcP = Int64(upcT) else {print("Hace falta el upc"); return}
            guard let weightT = self.pesoTF.text, let weightP = Double(weightT) else {print("Hace falta el peso"); return}
            
            // We create a Product object from the data collected
            let datos = Product(upc: upcP, itemName: nameP, description: descP,  unitaryWeight: weightP)
            
            let postRequest = APIRequest(endpoint: "import")
            // We send our object to the posting function
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n Nombre del producto: \(datos.itemName)\n Descripcion: \(datos.description)\n UPC: \(datos.upc)\n Peso: \(datos.unitaryWeight)")
                    
                    // If process is sucessful move on to next scene
                    DispatchQueue.main.async(){
                       self.performSegue(withIdentifier: "addingProduct", sender: self)
                    }
                    
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })
        }))
        
        self.present(alert, animated: true)
    }// end Of RegistrarAction
    
    // We declare our textfields
    @IBOutlet weak var upcTF: UITextField!
    
    @IBOutlet weak var nombreTF: UITextField!
    
    @IBOutlet weak var descripcionTF: UITextField!
    
    @IBOutlet weak var pesoTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - CONNECTING TO FOLLOWING SCENES
    // We declare a donation object for managing its data
    var donation : Donation?
    
    // We send its data to the following scene, deppending on the button pressed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Recieving prepare");
        if segue.identifier == "selectProduct" {
            let controller = (segue.destination as! SelectProductViewController)
            print("Recognizing identifier")
            
            // We will retrieve products from DB
            importationService.getProducts() {
                (products) in
                DispatchQueue.main.async {
                    print("Entering dispatch queue")
                    controller.products = products;
                    controller.tableView.reloadData();
                    controller.donation = self.donation;
                }
            }
        } else if segue.identifier == "addingProduct" {
            let controller = (segue.destination as! RegisterLineViewController)
            // We initialize values for a donation line
            let upcT = self.upcTF.text!;
            let upcN = Int64(upcT)!
            let weightT = Double(self.pesoTF.text!)!;
            let productToSend = Product(upc: upcN, itemName: self.nombreTF.text!, description: self.descripcionTF.text!, unitaryWeight: weightT);
            
            DispatchQueue.main.async {
                controller.donation = self.donation;
                controller.product = productToSend;
            }
        } else if segue.identifier == "checkImportation" {
            let controller = (segue.destination as! CheckImportationViewController)
            // We retrieve the current donation
            DispatchQueue.main.async {
                controller.donation = self.donation;
            }
        } else if segue.identifier == "finishImportation" {
            importationService.publishDonation(donation: donation!) {
                // We post the donation
                () in
                print("Sending importation...")
            }
        }
    }
}// end of class
