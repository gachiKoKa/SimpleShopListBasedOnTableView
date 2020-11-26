//
//  ViewController.swift
//  HackingWithSwift Project 3 (Shop List)
//
//  Created by Константин Кек on 25.11.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var products = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        
        return cell

    }

    @objc func addProduct() {
        let alertController = UIAlertController(title: "Enter wanted product", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [unowned alertController] _ in
            if let answer = alertController.textFields?[0].text {
                if answer.isEmpty {
                    let errorAlertController = UIAlertController(title: "Error", message: "You've enetered nothing", preferredStyle: .alert)
                    errorAlertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(errorAlertController, animated: true)
                } else {
                self.products += [answer]
                self.tableView.insertRows(at: [IndexPath(row: self.products.count-1, section: 0)], with: .automatic)
                }
            }
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    @objc func clearList() {
        if products.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "The list is empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alertController, animated: true)
        }
        products = [String]()
        tableView.reloadData()
    }

}

