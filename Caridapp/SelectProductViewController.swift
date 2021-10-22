//
//  SelectProductViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/11/21.
//

import UIKit

class SelectProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var donation : Donation?
    
    var products : [Product]? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Getting into setter")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell {
            print("Updating cell for \(indexPath.row)")
            let product = products?[indexPath.row]
            cell.updateCell(product: product!)
            return cell
        }
        return UITableViewCell()
    }

}
