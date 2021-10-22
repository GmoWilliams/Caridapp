//
//  VewControllerBDA14_2.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

class ViewControllerBDA14_2: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var expireTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!

    var datePicker :UIDatePicker!
    var lineV:LinePV?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        expireTextField.delegate = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        expireTextField.placeholder = dateFormatter.string(from: lineV!.productExpiration)
        
        quantityTextField.placeholder = "\((lineV!.originalQuantity))"
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.minimumDate = Date()
        datePicker.timeZone = TimeZone(identifier: "GMT")
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
               expireTextField.inputView = datePicker
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        expireTextField.inputAccessoryView = toolBar
        
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(verifyLine))
        
    }
    
    @IBAction func verifyLine(_ sender: Any) {
        
        let alert = UIAlertController(title: "Corregir Datos", message: "Se corregira la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            let donationIDPV = Int64(self.lineV!.donationID);
            let lineIDPV = Int64(self.lineV!.lineID);

            //let eTF = self.expireTextField.text
            
            var expP = self.datePicker.date
            if self.expireTextField.text == "" {
               expP = self.lineV!.productExpiration
            }

            var quantityText = self.quantityTextField.text!
            if self.quantityTextField.text == "" {
                quantityText = String(self.lineV!.originalQuantity)
            }
            let quantP = Int(quantityText)!

            //guard let pickUpT = self.pickUpTF.text, let weightP = Double(pickUpT) else {print("Hace falta el peso"); return}

            print("donationID: ",donationIDPV," \nLineID: " ,lineIDPV, "\nquan: ", quantP , "\nexpP: ", expP)

            let datos = LineVerificaion(donationID: donationIDPV, lineID: lineIDPV, productExpiration: expP , quantity: quantP)
            
            let postRequest = APIRequest3(endpoint: "verifyLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Cantidad: \(datos.quantity)")

                    DispatchQueue.main.async(){
                        let vc = self.storyboard?.instantiateViewController(identifier: "BDA-14ID") as! ViewControllerBDA14
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })

        }))

        self.present(alert, animated: true)
             
 
    }//end of corregirAction
    
    @objc func datePickerDone() {
           expireTextField.resignFirstResponder()
       }

    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let selectedDate = dateFormatter.string(from: datePicker.date)
            expireTextField.text = selectedDate
            print(datePicker.date)
        let timeZone = TimeZone.current.identifier
         print(timeZone)
       }
    
}



