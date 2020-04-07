//
//  ViewController.swift
//  Day23
//
//  Created by Aaron Dupont on 4/7/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("@2x.png"){
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return pictures.count
       }
       
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
       var title = pictures[indexPath.row].uppercased()
       title.removeLast(7)
       cell.textLabel?.text = title
       return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
        vc.selectedFlag = pictures[indexPath.row]
           navigationController?.pushViewController(vc, animated: true)
       }
   }


}

