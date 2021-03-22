//
//  ViewController.swift
//  Project1
//
//  Created by Aaron Dupont on 10/2/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var statistics = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
//        loadImageTitles()
        performSelector(inBackground: #selector(loadImageTitles), with: nil)
        
        //load data from defaults
        let defaults = UserDefaults.standard
        
        if let savedStatistics = defaults.object(forKey: "stats") as? Data {
            let decoder = JSONDecoder()
            do {
                statistics = try decoder.decode([String: Int].self, from: savedStatistics)
            } catch {
                print("error loading statistics from User Defaults")
            }
        }
        
        
        tableView.reloadData()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let savedStatistics = try? encoder.encode(statistics) as Data{
            let defaults = UserDefaults.standard
            defaults.setValue(savedStatistics, forKey: "stats")
        }
    }
    
    @objc func loadImageTitles() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let imageName = pictures[indexPath.row]
        cell.textLabel?.text = imageName
        cell.detailTextLabel?.text = "\(statistics[imageName] ?? 0)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            let selectedImageName = pictures[indexPath.row]
            vc.selectedImage = selectedImageName
            if let navigationController = navigationController {
                navigationController.pushViewController(vc, animated: true)
            } else {
                print("issue pushing view controller")
            }
            

            //update stats here
            statistics[selectedImageName] = ( statistics[selectedImageName] ?? 0 ) + 1
            print(statistics)
            tableView.reloadRows(at: [indexPath], with: .none)
            //prob should only save on app close etc
            save()
        } else {
            print("issue creating detail view controller")
        }
    }

}

