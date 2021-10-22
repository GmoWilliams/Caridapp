//
//  LineTableViewController.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//
import UIKit


class LineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var LineTableView: UITableView!
    
    var lineS = [LineP]()
    
    
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CARIDAPP"
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

        downloadJSON {
            print ("Successful")
            self.LineTableView.reloadData()
        }
        LineTableView.delegate = self
        LineTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = .init(identifier: "es_MX")
        //dateFormatter.timeZone = TimeZone(identifier: "America/Chihuahua")
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let Date1 = dateFormatter.string(from: lineS[indexPath.row].pickUpDate)
            
        cell.textLabel?.text = String(lineS[indexPath.row].itemName) + ", \nSe recogera el dia: " + String(Date1)
        cell.textLabel?.numberOfLines = 4;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        print(lineS[indexPath.row].pickUpDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LineViewController {
            destination.lineZ = lineS[(LineTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://caridapp.herokuapp.com/historyLine")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                    do {
                        
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        dateFormatter.timeZone = TimeZone(identifier:"GMT")
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
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
