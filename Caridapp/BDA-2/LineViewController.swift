//
//  LineViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//

import UIKit

class LineViewController: UIViewController {
    // Variable of type LineP for managing values from retrieved Lines from DB
    var lineZ:LineP?
    
    // MARK: - corregirAction
    @IBAction func corregirAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Corregir Datos", message: "Se corregira la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            
            // We initialize the values retrieved from past scene, IDs are never modified
            let lineIDP = Int64(self.lineZ!.lineID);
            let donaIDP = Int64(self.lineZ!.donationID);
            
            // If a textfield is blank it will take the value retrieved from DB
            var uCostT = self.unitaryCostTF.text!
                if self.unitaryCostTF.text == "" {
                    uCostT = String(self.lineZ!.unitaryCost)
                }
                let uCostP = Float(uCostT)!
            
            var quantT = self.quantityTF.text!
            if self.quantityTF.text == "" {
                quantT = String(self.lineZ!.originalQuantity)
            }
            let quantP = Int(quantT)!
            
            // For date textfields values will be picked from datePicker tool
            var expP = self.datePicker.date
            if self.expirationTF.text == "" {
               expP = self.lineZ!.productExpiration
            }
            
            var pickP = self.datePicker2.date
            if self.pickUpTF.text == "" {
               pickP = self.lineZ!.pickUpDate
            }
            
            // All values are now initialized in an object for Updating Line in DB
            let datos = LineUpdate(lineID: lineIDP, donationID: donaIDP, unitaryCost: uCostP, originalQuantity: quantP, pickUpDate: pickP, productExpiration: expP)
            
            // We make an APIRequest, in this case it will be a put request and it will manage dates
            let postRequest = APIRequest2(endpoint: "updateLine")
            postRequest.save(datos, completion: {result in
                switch result{
                // If connection & decodification is succesful, print the data sent
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Costo Unitario: \(datos.unitaryCost)\n Cantidad: \(datos.originalQuantity)\n Expiracion: \(datos.productExpiration) \n Recoger: \(datos.pickUpDate)")
                    
                    // Scene will move then to previous one (Listing current Lines)
                    DispatchQueue.main.async(){
                        let vc = self.storyboard?.instantiateViewController(identifier: "LineTableID") as! LineTableViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })
// */
        }))
 
        
        self.present(alert, animated: true)
    }//end of corregirAction
    
    // MARK: - Declaring Labels
    @IBOutlet weak var unitaryCostTF: UITextField!
    
    @IBOutlet weak var expirationTF: UITextField!
    
    @IBOutlet weak var quantityTF: UITextField!
    
    @IBOutlet weak var pickUpTF: UITextField!
    
    var datePicker :UIDatePicker!
    var datePicker2: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        let dateFormatter = DateFormatter()
        // Desired format for date output
        dateFormatter.dateFormat = "E, MMM d, yyyy ZZZZ"
        // Desired language for date output
        dateFormatter.locale = .init(identifier: "es_MX")
        // Desired timezone for date output *NOTE: It MUST be GMT to match DBs format
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        // We give as placeholder the retrieved data for each textfield, for convenience
        unitaryCostTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        expirationTF.placeholder = dateFormatter.string(from: lineZ!.productExpiration)
        
        quantityTF.placeholder = "\((lineZ?.originalQuantity)!)"
        
        
        pickUpTF.placeholder = dateFormatter.string(from: lineZ!.pickUpDate)
        
        // MARK: - DatePicker
        // *NOTE: This process can be optimized to a single function for both labels, but it requires a method that allows giving #selector a parameter
        
        // DatePicker#1
                // We initiate datePicker window with the given size
            datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
                // We just want to ask for date
            datePicker.datePickerMode = UIDatePicker.Mode.date
                // We do not allow past dates to be selected
            datePicker.minimumDate = Date()
                // We MUST have timezone GMT to match DBs format
            datePicker.timeZone = TimeZone(identifier:"GMT")
                // We declare action for datePicker
            datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
                   expirationTF.inputView = datePicker
        
        // We give format to doneButton
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
                   let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
                expirationTF.inputAccessoryView = toolBar
        
            // DatePicker#2
        
            datePicker2 = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
            datePicker2.datePickerMode = UIDatePicker.Mode.date
            datePicker2.minimumDate = Date()
            datePicker2.timeZone = TimeZone(identifier:"GMT")
            
            datePicker2.addTarget(self, action: #selector(self.dateChanged2), for: .allEvents)
                   pickUpTF.inputView = datePicker2
        
        let doneButton2 = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone2))
                   let toolBar2 = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
            toolBar2.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton2], animated: true)
                pickUpTF.inputAccessoryView = toolBar2
    }
    
    @objc func datePickerDone() {
           expirationTF.resignFirstResponder()
       }

    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy ZZZZ"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
            expirationTF.text = selectedDate
       }
    
    @objc func datePickerDone2() {
           pickUpTF.resignFirstResponder()
       }

    @objc func dateChanged2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        let selectedDate = dateFormatter.string(from: datePicker2.date)
            pickUpTF.text = selectedDate
       }

}// endOfClass
