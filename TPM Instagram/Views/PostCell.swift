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
    
    @IBOutlet weak var profilePictureIconImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var commentButtonImageView: UIImageView!
    @IBOutlet weak var offlineSaveButtonImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var post: Post! {
        didSet {
            profilePictureIconImageView.af_setImage(withURL: post.userImageUrl as URL)
            usernameLabel.text = post.username
            locationLabel.text = post.location
            postImageView.file = post.postImage
            likeButtonImageView.image = #imageLiteral(resourceName: "favor-icon")
            commentButtonImageView.image = #imageLiteral(resourceName: "comment-icon")
            offlineSaveButtonImageView.image = #imageLiteral(resourceName: "offline-save-icon")
            numberOfLikesLabel.text = post.favoritesCount as? String
            captionLabel.text = post.caption
        }
    }
}
