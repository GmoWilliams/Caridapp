//
//  LineViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//
extension UIViewController {
    func hideKeyboardWhenTappedAround2() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard2() {
        view.endEditing(true)
    }
}

import UIKit

class LineViewController: UIViewController {
    
    var lineZ:LineP?
    
    @IBAction func corregirAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Corregir Datos", message: "Se corregira la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            let lineIDP = Int64(self.lineZ!.lineID);
            let donaIDP = Int64(self.lineZ!.donationID);
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
            
            let eTF = self.expirationTF.text
            let pTF = self.pickUpTF.text
            
        
            
            var pickP = self.datePicker.date
            if self.pickUpTF.text == "" {
               pickP = self.lineZ!.pickUpDate
            }
            
            var expP = self.datePicker.date
            if self.expirationTF.text == "" {
               expP = self.lineZ!.productExpiration
            }

            
            print("pickP: ",pickP,"\n", "expP:",expP,"\n","current PickUp:",self.lineZ!.pickUpDate,"\n", "current Expiration:",self.lineZ!.productExpiration,"\n", "datePicker:",self.datePicker.date,"\n", "pTF:",self.pickUpTF.text!,"\n", "eTF:",self.expirationTF.text!,"\n")
            
 
 let datos = LineUpdate(lineID: lineIDP, donationID: donaIDP, unitaryCost: uCostP, originalQuantity: quantP, pickUpDate: pickP, productExpiration: expP)
            //let datos = LineUpdate(lineID: lineIDP, unitaryCost: uCostP, originalQuantity: quantP)
            
            let postRequest = APIRequest2(endpoint: "updateLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Costo Unitario: \(datos.unitaryCost)\n Cantidad: \(datos.originalQuantity)\n Expiracion: \(datos.productExpiration) \n Recoger: \(datos.pickUpDate)")
                    
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
    

    @IBOutlet weak var unitaryCostTF: UITextField!
    
    @IBOutlet weak var expirationTF: UITextField!
    
    @IBOutlet weak var quantityTF: UITextField!
    
    @IBOutlet weak var pickUpTF: UITextField!
    
    var datePicker :UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        
        unitaryCostTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        expirationTF.placeholder = dateFormatter.string(from: lineZ!.productExpiration)
        
        quantityTF.placeholder = "\((lineZ?.originalQuantity)!)"
        
        pickUpTF.placeholder = dateFormatter.string(from: lineZ!.pickUpDate)
        
        
            datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
            datePicker.datePickerMode = UIDatePicker.Mode.date
            datePicker.minimumDate = Date()
            
            datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
                   expirationTF.inputView = datePicker
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
                   let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
                expirationTF.inputAccessoryView = toolBar
        
    }
    
    @objc func datePickerDone() {
           expirationTF.resignFirstResponder()
       }

    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        let selectedDate = dateFormatter.string(from: datePicker.date)
            expirationTF.text = selectedDate
            print(datePicker.date)
        let timeZone = TimeZone.current.identifier
         print(timeZone)
       }
    
    @objc func datePickerDone2() {
           expirationTF.resignFirstResponder()
       }

    @objc func dateChanged2() {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        //dateFormatter.locale = .init(identifier: "es_MX")
        //dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        let selectedDate = dateFormatter.string(from: datePicker.date)
            expirationTF.text = selectedDate
            print(datePicker.date)
        
       }

}
