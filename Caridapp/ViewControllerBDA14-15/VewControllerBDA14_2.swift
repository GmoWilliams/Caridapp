//
//  VewControllerBDA14_2.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

@IBDesignable class ViewControllerBDA14_2: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var updateExpire: UITextField!

    
    var line: String?
    
    var update: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateExpire.delegate = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(updateLine))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        updateLine()
        
        return true
    }
    
    @objc func updateLine() {
        
        guard let text = updateExpire.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }

        
        UserDefaults().set(text, forKey: "line_\(count)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

