//
//  viewControllerHoma.swift
//  Caridapp
//
//  Created by user196197 on 10/15/21.
//
import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {

    @IBOutlet var sideMenuTableView: UITableView!
   

    var defaultHighlightedCell: Int = 0

    var menu: [SideMenuModel] = [
        //SideMenuModel(title: "Inicio"),
        //SideMenuModel(title: "Agregar Donacion (BDA-2)"),
        SideMenuModel(title: "Modificar Donacion (BDA-1, 11)"),
        SideMenuModel(title: "Verificar Donacion (temporal BDA-14,15)"),
//        SideMenuModel(title: "Carga Recibida (temporal BDA-13)"),
//        SideMenuModel(title: "Agregar Donador (temporal BDA-8)"),
    ]
    
    var delegate: SideMenuViewControllerDelegate?

    var imageView: UIImageView = {
       let imageView = UIImageView(frame: .zero)
       imageView.image = UIImage(named: "SideMenuB.jpeg")
       imageView.contentMode = .scaleToFill
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        // TableView
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.separatorStyle = .none

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }



        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.titleLabel.text = self.menu[indexPath.row].title

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.1501106389, green: 0.269132077, blue: 0.4949238579, alpha: 0.8390410959)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ...
        self.delegate?.selectedCell(indexPath.row)
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
    }
}
