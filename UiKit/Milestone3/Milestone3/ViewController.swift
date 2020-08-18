//
//  ViewController.swift
//  Milestone3
//
//  Created by Aaron Dupont on 8/18/20.
//  Copyright © 2020 Aaron Dupont. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddNew))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[0]
        return cell
    }
    
    @objc func clearList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func presentAddNew(){
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.add(item: item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func add(item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

}

