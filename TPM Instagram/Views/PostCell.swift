//
//  PostCell.swift
//  TPM Instagram
//
//  Created by Samman Thapa on 1/4/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse
import ParseUI
import AlamofireImage


class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePictureIconImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var commentButtonImageView: UIImageView!
    @IBOutlet weak var offlineSaveButtonImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var post: PFObject! {
        didSet {
            profilePictureIconImageView.file = post["media"] as? PFFile
            usernameLabel.text = (post["author"] as? PFUser)?.username
            locationLabel.text = post["location"] as? String
            
            postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            
            likeButtonImageView.image = #imageLiteral(resourceName: "favor-icon")
            commentButtonImageView.image = #imageLiteral(resourceName: "comment-icon")
            offlineSaveButtonImageView.image = #imageLiteral(resourceName: "offline-save-icon")
            numberOfLikesLabel.text = post["likesCount"] as? String
            captionLabel.text = post["caption"] as? String
        }
    }
}
