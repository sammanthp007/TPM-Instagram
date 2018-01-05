//
//  FeedsViewController.swift
//  TPM Instagram
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse
import ParseUI

class FeedsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts : [Post] = []
    var raw_posts: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // edit navbar
        self.navigationItem.title = "TPM Instagram"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(red: 1.0, green: 0.25, blue: 0.25, alpha: 0.8)
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.gray.withAlphaComponent(0.5)
            shadow.shadowOffset = CGSize(width: 2, height: 2)
            
            shadow.shadowBlurRadius = 4
            
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 22),
                NSAttributedStringKey.foregroundColor : UIColor(red: 0.5, green: 0.15, blue: 0.15, alpha: 0.8),
                NSAttributedStringKey.shadow : shadow
            ]
        }
        
        // For collection View
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getData()
    }
    
    func getData() -> Void {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("Posts are: ", posts)
                // do something with the data fetched
                self.raw_posts = posts
                
            } else {
                print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                // handle error
            }
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.raw_posts.count != 0 {
            return self.raw_posts.count
        } else {
            print ("came here")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        
       
        cell.post = self.raw_posts[indexPath.row]
        return cell
    }
    
    
}

