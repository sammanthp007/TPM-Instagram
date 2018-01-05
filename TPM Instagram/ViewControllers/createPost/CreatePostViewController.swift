//
//  CreatePostViewController.swift
//  TPM Instagram
//
//  Created by Samman Thapa on 1/5/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse


class CreatePostViewController: UIViewController {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var postImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postImageView.image = postImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(upload))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func upload() -> Void {
//        MBProgressHUD.showAdded(to: self.view, animated: true)

        Post.postUserImage(image: postImage,
                           withCaption: captionTextField.text,
                           withCompletion: { (success: Bool, error: Error?) -> Void in
                            // MBProgressHUD.showAdded(to: self.view, animated: true)
                            DispatchQueue.main.async {
                                self.postImageView.image = nil
                                self.captionTextField.text = nil
//                                MBProgressHUD.hide(for: self.view, animated: true)
                            }}
        )
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
