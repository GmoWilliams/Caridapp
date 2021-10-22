//
//  checkImportationViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/14/21.
//

import UIKit

class CheckImportationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var donation : Donation?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donation?.lineArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as? LineTableViewCell {
            let line = donation?.lineArray[indexPath.row]
            cell.updateCell(line: line!)
            return cell
        }

        return UITableViewCell()
    }

}
