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
            var uCostT = self.unitaryCostTF.text!
                if self.unitaryCostTF.text == "" {
                    uCostT = String(self.lineZ!.unitaryCost)
                }
                let uCostP = Float(uCostT)!
            
            //guard let expirP = self.expirationTF.text else {print("Hace falta la descripcion"); return}
            
            var quantT = self.quantityTF.text!
            if self.quantityTF.text == "" {
                quantT = String(self.lineZ!.originalQuantity)
            }
            let quantP = Int(quantT)!
            //guard let pickUpT = self.pickUpTF.text, let weightP = Double(pickUpT) else {print("Hace falta el peso"); return}
            
            //print(lineIDP, uCostP, quantP)
            
            let datos = LineUpdate(lineID: lineIDP, unitaryCost: uCostP, originalQuantity: quantP)
            
            let postRequest = APIRequest2(endpoint: "updateLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Costo Unitario: \(datos.unitaryCost)\n Cantidad: \(datos.originalQuantity)")
                    
                    DispatchQueue.main.async(){
                       self.performSegue(withIdentifier: "showLines", sender: self)
                    }
                    
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
                })

        }))
        
        self.present(alert, animated: true)
             
 
    }//end of corregirAction
    

    @IBOutlet weak var unitaryCostTF: UITextField!
    
    @IBOutlet weak var expirationTF: UITextField!
    
    @IBOutlet weak var quantityTF: UITextField!
    
    @IBOutlet weak var pickUpTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        unitaryCostTF.placeholder = "\((lineZ?.unitaryCost)!)"
        
        //expirationTF.placeholder = "\((lineZ?.productExpiration)!)"
        
        expirationTF.placeholder = dateFormatter.string(from: lineZ!.productExpiration)
        
        quantityTF.placeholder = "\((lineZ?.originalQuantity)!)"
        
        /*
        print("\((lineZ?.lineID)!)")
        print("\((lineZ?.donationID)!)")
        print("\((lineZ?.itemName)!)")
        print("\((lineZ?.upc)!)")
        print("\((lineZ?.quantity)!)")
        print("\((lineZ?.originalQuantity)!)")
        print("\((lineZ?.unitaryCost)!)")
        */
    }
    
    /*
    let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
    */

}
