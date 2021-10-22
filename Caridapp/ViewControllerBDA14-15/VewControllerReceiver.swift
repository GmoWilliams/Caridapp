//
//  VewControllerReceiver.swift
//  Caridapp
//
//  Created by user196197 on 9/28/21.
//

import UIKit

class ViewControllerReceiver: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet var donatTble: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CARIDAPP"

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        self.hideKeyboardWhenTappedAround()
        
        downloadJSON {
            print ("Successful")
            self.donatTble.reloadData()
        }

        donatTble.delegate = self
        donatTble.dataSource = self
        
    }
    
    
    
    var donations = [DonationPV]()
    var stopLight = [String]()
    var light: Int = 0

    
    func downloadJSON(completed: @escaping () -> () ) {
           let url = URL(string: "https://caridapp.herokuapp.com/historyDonation")
           //let url = URL(string: "https://api.opendota.com/api/heroStats")
           
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               if error == nil {
                       do {
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
                        dateFormatter.timeZone = TimeZone(identifier:"GMT")
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                           
                           self.donations = try decoder.decode([DonationPV].self, from: data!)
                           //self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                           DispatchQueue.main.async {
                               completed()
                           }
                           
                   } catch {
                       print("JSON Error")
                   }
               }
           }.resume()
       }
}

    

extension ViewControllerReceiver: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = storyboard?.instantiateViewController(identifier: "task") as! ViewControllerBDA14_2
//        navigationController?.pushViewController(vc, animated: true)
          self.performSegue(withIdentifier: "ShowLineV", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewControllerBDA15 {
            destination.DonationV = donations[(donatTble.indexPathForSelectedRow?.row)!]
        }
    }
}
    

extension ViewControllerReceiver: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.donations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
               //cell.textLabel?.text = heroes[indexPath.row].localized_name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_ES")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let Date1 = dateFormatter.string(from: donations[indexPath.row].pickUpDate)
//        let string = "O"
//        let shadow = NSShadow()
//        shadow.shadowColor = UIColor.red
//        shadow.shadowBlurRadius = 5
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white
//        ]

//        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text =  "Donacion: " + String(donations[indexPath.row].donationID) + "\nRecogida el día: " + String(Date1) + "\nRecogida por chofer: " + String(donations[indexPath.row].warehouse)
        cell.textLabel?.numberOfLines = 3;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        
        return cell
    }

}
