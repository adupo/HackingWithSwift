//
//  ViewController.swift
//  Project7
//
//  Created by Aaron Dupont on 8/24/20.
//  Copyright © 2020 Aaron Dupont. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
     @objc func fetchJSON() {
        let urlString: String //"https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
        }
        
        let creditsButton = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditAlert))
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterAlert))
        navigationItem.leftBarButtonItem = creditsButton
        navigationItem.rightBarButtonItem = filterButton
        
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                    return
                }
            }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func filterAlert() {
        let ac = UIAlertController(title: "Filter", message: "Filter the petitions based on keywords entered below", preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] action in
            guard let filterText = ac?.textFields?[0].text else {return}
            self?.filterPetitions(for: filterText)
        })
        
        present(ac, animated: true)
    }
    
    func filterPetitions(for filterText: String) {
        var tempPetitionList = [Petition]()
        for petition in petitions {
            if petition.title.lowercased().contains(filterText) || petition.body.lowercased().contains(filterText) {
                tempPetitionList.append(petition)
            }
        }
        filteredPetitions = tempPetitionList
        print("Petition count: \(petitions.count); filtered count \(filteredPetitions.count)")
        tableView.reloadData()
    }
    
    @objc func creditAlert() {
        let ac = UIAlertController(title: "Source", message: "This data is brought to you by Paul Hudson's copy of the whitehouse API.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Done", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError() {
            let ac = UIAlertController(title: "Loading error", message: "There was an errror loading the feed. Please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

