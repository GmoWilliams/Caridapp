//
//  LineTableViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//
import UIKit

class LineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Variable of type LineP for managing values from retrieved Lines from DB
    var lineS = [LineP]()
    
    @IBOutlet weak var LineTableView: UITableView!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CARIDAPP"
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

        LineTableView.accessibilityIdentifier = "BDA-2 LineTable"
        
        // Call made when retrieving data works
        downloadJSON {
            print ("Successful")
            self.LineTableView.reloadData()
        }
        LineTableView.delegate = self
        LineTableView.dataSource = self
    }
    
    // MARK: - TABLE & ROWS DISPLAY
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineS.count
        // We want table to have as many rows as objects retrieved from APIRequest
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        // Format for listed dates per Line
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let Date1 = dateFormatter.string(from: lineS[indexPath.row].pickUpDate)
        
        // Text shown per row
        cell.textLabel?.text = String(lineS[indexPath.row].itemName) + ", \nSe recogera el dia: " + String(Date1)
        cell.textLabel?.numberOfLines = 4;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // When clicked, each rows leads to next scene
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We send to next scene the data we retrieved from DB, which is now stored in the row
        if let destination = segue.destination as? LineViewController {
            destination.lineZ = lineS[(LineTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // MARK: - RETRIEVING FUNCTION
    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://caridapp.herokuapp.com/historyLine")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                    do {
                        
                        // We MUST specify correctly the decoding format to match what DB is sending
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        dateFormatter.timeZone = TimeZone(identifier:"GMT")
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        // Decoding our object from JSON
                        self.lineS = try decoder.decode([LineP].self, from: data!)
                        
                        if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                            print("JSON String: \(jsonResponse)")
                        }
                        
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
