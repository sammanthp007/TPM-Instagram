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
        
        // update flow layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellsPerLine:CGFloat = 1
        let widthOfEachItem = self.view.frame.size.width // collectionView.frame.size.width / cellsPerLine
        layout.itemSize = CGSize(width: widthOfEachItem, height: widthOfEachItem * 1.75)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 4
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        self.collectionView.insertSubview(refreshControl, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getData(completion: {(success: Bool, error: Error?) -> Void in
            if success {
                print ("successfully received data")
            } else {
                print (error?.localizedDescription)
            }
        })
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getData(completion: {(success: Bool, error: Error?) -> Void in
            if success {
                print ("successfully received data")
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
            } else {
                print (error?.localizedDescription)
            }
        })
    }
    
    func getData(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) -> Void {
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
                completion(true, nil)
                
            } else {
                print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                // handle error
                completion(false, error)
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

