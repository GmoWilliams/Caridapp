//
//  ViewControllerBDA14.swift
//  Caridapp
//
//  Created by user196197 on 9/19/21.
//

import UIKit


class ViewControllerBDA14: UIViewController {

    
    @IBOutlet var verifTble: UITableView!
    
    var lines = [LinePV]()
    var DonationV:DonationPV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "VERIFICACION"
        verifTble.accessibilityIdentifier = "BDA-14 verifTble"
        downloadJSON {
            print ("Successful")
            self.verifTble.reloadData()
        }
        verifTble.delegate = self
        verifTble.dataSource = self
        
        
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
        let donationIDPV = String(self.DonationV!.donationID);
        //let postRequest = APIRequest5(endpoint: donationIDPV)
        let api = "https://caridapp.herokuapp.com/historyVerify"
        let endpoint = "/\(donationIDPV)"
        let url = URL(string: api + endpoint)
           
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               if error == nil {
                       do {
                           let decoder = JSONDecoder()
                           let dateFormatter = DateFormatter()
                           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
                           dateFormatter.timeZone = TimeZone(identifier:"GMT")
                           decoder.dateDecodingStrategy = .formatted(dateFormatter)
                            
                           
                           self.lines = try decoder.decode([LinePV].self, from: data!)
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


extension ViewControllerBDA14: UITableViewDelegate {
    
    //function which shows next screen based on segue 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

          self.performSegue(withIdentifier: "ShowVerify", sender: self)
    }
    
    //function to prepare data to be sended towards the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let destination = segue.destination as? ViewControllerBDA14_2 {
            destination.lineV = lines[(verifTble.indexPathForSelectedRow?.row)!]
        } else if let destination = segue.destination as? ViewControllerBDA15 {
            destination.DonationV = DonationV
        }
    }
}
    

extension ViewControllerBDA14: UITableViewDataSource {
    
    //Function which designates number of cells to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.lines.count
    }
    
    //This function displays the data gotten from JSON in string format in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy"
        dateFormatter.locale = .init(identifier: "es_ES")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let Date1 = dateFormatter.string(from: lines[indexPath.row].productExpiration)

        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text =  String(lines[indexPath.row].itemName) + "\nExpira el día: " + String(Date1) + "\nCantidad: " + String(lines[indexPath.row].quantity) + "\nDonacionID: " + String(lines[indexPath.row].donationID)
        cell.textLabel?.numberOfLines = 4;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        
        return cell
    }

}

