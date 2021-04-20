//
//  ViewController.swift
//  Consolidation5
//
//  Created by Aaron Dupont on 3/24/21.
//

import UIKit

struct Post: Codable {
    var imageName: String
    var caption: String
}
//TODO: go to detail view showing picture, add captions

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Solo-Insta"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicture))
        
        load()
    }
    
    @objc func addPicture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("error getting image in didFinishPickingMediaWithInfo")
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add caption", message: "Please add a caption now.", preferredStyle: .alert)
        ac.addTextField()
        let postAction = UIAlertAction(title: "Post", style: .default) { [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            let post = Post(imageName: imageName, caption: caption)
            self?.posts.append(post)
            self?.save() //save to disk
            self?.tableView.reloadData()
        }
        ac.addAction(postAction)
        
        present(ac, animated: true)
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let jsonPosts = try? encoder.encode(posts) {
            let defaults = UserDefaults.standard
            defaults.set(jsonPosts, forKey: "posts")
        } else {
            print("did not save posts")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let jsonPosts = defaults.object(forKey: "posts") as? Data {
            let decoder = JSONDecoder()
            do {
                posts = try decoder.decode([Post].self, from: jsonPosts)
            } catch {
                print("issue loading posts from user defaults")
            }
            
            tableView.reloadData()
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            vc.post = posts[indexPath.row]
            if let navigationController = navigationController {
                navigationController.pushViewController(vc, animated: true)
            } else {
                print("issue pushing detail view controller")
            }
        } else {
            print("issue creating detail view controller")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}

