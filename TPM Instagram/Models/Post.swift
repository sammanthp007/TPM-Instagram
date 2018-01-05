//
//  Post.swift
//  TPM Instagram
//
//  Created by Samman Thapa on 1/5/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse
import ParseUI

class Post: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String?
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    @NSManaged var location: String?
    var hasFavorited: Bool?
    @NSManaged var idString: String
    
    @NSManaged var postedTimeStamp: NSDate?
    
    @NSManaged var authorUsername: String
    @NSManaged var authorProfileImageFile : PFFile
    
    // for printing purpose only
    var raw_post: PFObject?
    
//    init(dictionary: PFObject) {
//        super.init()
//
//        raw_post = dictionary
//
//        caption = (dictionary["caption"] as? String)!
//        commentsCount = (dictionary["comments_count"] as? Int) ?? 0
//        likesCount  = (dictionary["likes_count"] as? Int) ?? 0
//        location = dictionary["location"] as? String
//        media = dictionary["media"] as! PFFile
//        hasFavorited = dictionary["favorited"] as? Bool
//        idString = dictionary["id_str"] as? String
//
//        let timestampString = dictionary["created_at"] as? String
//        if let timestampString = timestampString {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//            postedTimeStamp = formatter.date(from: timestampString) as NSDate?
//        }
//
//        // the user associated with the post
//        let userDictionary = dictionary["author"] as! NSDictionary
//        authorUsername = (userDictionary["user_name"] as? String)!
//        authorProfileImageFile = (userDictionary["profile_image"] as? PFFile)!
//
//
//    }
    
//    class func getArrayOfPostsFromPFOjects(dictionaries: [PFObject]) -> [Post] {
//        var posts: [Post] = []
//        for dictionary in dictionaries {
//            let post = Post(dictionary: dictionary)
//            posts.append(post)
//        }
//
//        return posts
//    }
    
    func printTweetsUser() {
        print("\(String(describing: author))")
    }
    
    func printAll() {
        print("\(String(describing: raw_post))")
    }
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // resize the image
        let newSize = CGSize(width: 200, height: 300)
        let resizedImage = Post.resize(image: image!, newSize: newSize)
        
        // Create Parse object PFObject
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: resizedImage)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption
        post.likesCount = 0
        post.commentsCount = 0
        
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
