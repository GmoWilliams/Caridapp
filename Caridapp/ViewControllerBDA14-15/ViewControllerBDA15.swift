//
//  VewControllerBDA14_2.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

class ViewControllerBDA15: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var warehouseTextField: UITextField!


    var DonationV:DonationPV?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        warehouseTextField.delegate = self
        
        warehouseTextField.placeholder = "\((DonationV!.warehouse))"
        
        
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(verifyLine))
        
    }
    
    @IBAction func verifyDonation(_ sender: Any) {
        
        let alert = UIAlertController(title: "Guardar a almacén", message: "Se corregira la informacion al servidor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            let donationIDPV = Int64(self.DonationV!.donationID);


            var warehouseText = self.warehouseTextField.text!
            if self.warehouseTextField.text == "" {
                warehouseText = String(self.DonationV!.warehouse)
            }
            let warehouse = Int(warehouseText)!

            //guard let pickUpT = self.pickUpTF.text, let weightP = Double(pickUpT) else {print("Hace falta el peso"); return}

            //print("donationID: ",donationIDPV," \nLineID: " ,lineIDPV, "\nquan: ", quantP , "\nexpP: ", expP)

            let datos = DonationVerificaion(donationID: donationIDPV, warehouse: warehouse)
            
            let postRequest = APIRequest4(endpoint: "verifyDonation")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la donacion: \(datos.donationID)\n Almacen: \(datos.warehouse)")

                    DispatchQueue.main.async(){
                        let vc = self.storyboard?.instantiateViewController(identifier: "BDA-15ID") as! ViewControllerReceiver
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })

        }))

        self.present(alert, animated: true)
             
 
    }//end of corregirAction
    
}



