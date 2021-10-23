//
//  DriverTableViewCell.swift
//  Caridapp
//
//  Created by user194082 on 10/22/21.
//

import UIKit

class DriverTableViewCell: UITableViewCell {
    @IBOutlet weak var donationField: UILabel!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var addressField: UILabel!
    
    func updateCell(donation: DonationDriver){
        donationField.text = "Donacion " + String(donation.donationID)
        nameField.text = donation.nameD
        addressField.text = donation.deliveryAddress
    }
}
