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
            
            var expP = self.datePicker.date
            if self.expirationTF.text == "" {
               expP = self.lineZ!.productExpiration
            }
            
            var pickP = self.datePicker2.date
            if self.pickUpTF.text == "" {
               pickP = self.lineZ!.pickUpDate
            }
            
            /*print("pickP: ",pickP,"\n", "expP:",expP,"\n","current PickUp:",self.lineZ!.pickUpDate,"\n", "current Expiration:",self.lineZ!.productExpiration,"\n", "datePicker:",self.datePicker.date,"\n", "pTF:",self.pickUpTF.text!,"\n", "eTF:",self.expirationTF.text!,"\n")
            */
            print("Fecha sin formatear:", self.lineZ!.pickUpDate)
 
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
    var datePicker2: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy ZZZZ"
        dateFormatter.locale = .init(identifier: "es_MX")
        //dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        unitaryCostTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        expirationTF.placeholder = dateFormatter.string(from: lineZ!.productExpiration)
        
        quantityTF.placeholder = "\((lineZ?.originalQuantity)!)"
        
        
        pickUpTF.placeholder = dateFormatter.string(from: lineZ!.pickUpDate)
        
        
        // This process can be optimized to a single function for both labels, but it requires a method that allows giving #selector a parameter
        
            datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
            datePicker.datePickerMode = UIDatePicker.Mode.date
            datePicker.minimumDate = Date()
            datePicker.timeZone = TimeZone(identifier:"GMT")
            
            datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
                   expirationTF.inputView = datePicker
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
                   let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
                expirationTF.inputAccessoryView = toolBar
        
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
        //dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        let selectedDate = dateFormatter.string(from: datePicker.date)
            expirationTF.text = selectedDate
        print("Raw date: ",datePicker.date, " Selected date: ", selectedDate)
        
            
        let timeZone = TimeZone.current.identifier
         print(timeZone)
       }
    
    @objc func datePickerDone2() {
           pickUpTF.resignFirstResponder()
       }

    @objc func dateChanged2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        //dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let selectedDate = dateFormatter.string(from: datePicker2.date)
            pickUpTF.text = selectedDate
            print(datePicker2.date)
        let timeZone = TimeZone.current.identifier
         print(timeZone)
       }

}
