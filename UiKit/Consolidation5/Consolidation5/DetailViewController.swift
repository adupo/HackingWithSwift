//
//  DetailViewController.swift
//  Consolidation5
//
//  Created by Aaron Dupont on 4/20/21.
//

import UIKit

class DetailViewController: UIViewController {

    var post: Post?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            title = post.caption
            
            imageView.image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(post.imageName).path)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
