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
    //var heroes = [HeroStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadJSON {
            print ("Successful")
            self.LineTableView.reloadData()
        }
        LineTableView.delegate = self
        LineTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineS.count
        //return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = String(lineS[indexPath.row].itemName) + ", Cantidad: " +
            String(lineS[indexPath.row].originalQuantity)
        //cell.textLabel?.text = heroes[indexPath.row].localized_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LineViewController {
            destination.lineZ = lineS[(LineTableView.indexPathForSelectedRow?.row)!]
            //destination.hero = heroes[(LineTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://caridapp.herokuapp.com/historyLine")
        //let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                    do {
                        /*
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        JSONDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                        */
                        
                        self.lineS = try JSONDecoder().decode([LineP].self, from: data!)
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
