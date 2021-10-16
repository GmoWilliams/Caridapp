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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadJSON {
            print ("Successful")
            self.verifTble.reloadData()
        }

        // Get all current saved tasks
        verifTble.delegate = self
        verifTble.dataSource = self
        
//        if !UserDefaults().bool(forKey: "setup"){
//            UserDefaults().set(true, forKey: "setup")
//            UserDefaults().set(0, forKey: "count")
//        }
//        addLines()
    }
    
    func addLines() {
        
//        lines.removeAll()
//        guard let count = UserDefaults().value(forKey: "count") as? Int else{
//            return
//        }
//        for x in 0 ..< count {
//            if let line = UserDefaults().value(forKey: "line_\(x+1)")as? String {
//                lines.append(line)
//            }
//        }
//        verifTble.reloadData()
    }
    
    
    
    @IBAction func didTapEdit() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! ViewControllerBDA14Lines
        vc.update = {
            DispatchQueue.main.async {
                self.addLines()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
           let url = URL(string: "https://caridapp.herokuapp.com/VerifyLine")
           //let url = URL(string: "https://api.opendota.com/api/heroStats")
           
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               if error == nil {
                       do {
                           /*
                           let dateFormatter = DateFormatter()
                           dateFormatter.dateFormat = "yyyy-MM-dd"
                           JSONDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                           */
                           
                           self.lines = try JSONDecoder().decode([LinePV].self, from: data!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! ViewControllerBDA14_2
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension ViewControllerBDA14: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lines.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
               //cell.textLabel?.text = heroes[indexPath.row].localized_name
  
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = String(lines[indexPath.row].itemName) + ", Cantidad: " + String(lines[indexPath.row].quantity)
        return cell
    }

}

