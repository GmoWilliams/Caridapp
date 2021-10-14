//
//  ViewControllerBDA14.swift
//  Caridapp
//
//  Created by user196197 on 9/19/21.
//

import UIKit


class ViewControllerBDA14: UIViewController {

    
    @IBOutlet var verifTble: UITableView!
    
    var lines = [String]()
    var tableViewDataSource = Array(0...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get all current saved tasks
        verifTble.delegate = self
        verifTble.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        addLines()
    }
    
    func addLines() {
        
        lines.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0 ..< count {
            if let line = UserDefaults().value(forKey: "line_\(x+1)")as? String {
                lines.append(line)
            }
        }
        verifTble.reloadData()
    }
    
    
    func updateLines() {
        
        lines.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        for x in 0 ..< count {
            if let line = UserDefaults().value(forKey: "line_\(x+1)")as? String {
                lines.insert(line, at: x)
            }
        }
        verifTble.reloadData()
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
}

extension ViewControllerBDA14: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! ViewControllerBDA14_2
        vc.line = lines[indexPath.row]
        vc.update = {
            DispatchQueue.main.async {
                self.updateLines()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension ViewControllerBDA14: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lines.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(self.lines[indexPath.row])"
        return cell
    }

}

