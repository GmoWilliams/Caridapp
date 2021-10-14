//
//  ViewControllerBDA14Lines.swift
//  Caridapp
//
//  Created by user196197 on 10/9/21.
//

import UIKit

class ViewControllerBDA14Lines: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet var addLine: UITextField!
    
    var update: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLine.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveLine))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveLine()
        
        return true
    }
    
    @objc func saveLine() {
        
        guard let text = addLine.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "line_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    
}

