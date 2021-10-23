//
//  DriverImportationsTableViewController.swift
//  Caridapp
//
//  Created by user194082 on 10/22/21.
//

import UIKit

class DriverImportationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let driverService = DriverService()
    
    var donations: [DonationDriver]? {
        didSet {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.driverService.getDonations() {
                (donations) in
                self.donations = donations
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Getting into setter")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "driverCell", for: indexPath) as? DriverTableViewCell {
            print("Updating cell for \(indexPath.row)")
            let donation = donations?[indexPath.row]
            cell.updateCell(donation: donation!)
            return cell
        }
        return UITableViewCell()
    }


}
