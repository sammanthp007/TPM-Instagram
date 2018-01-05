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
    
    var caption: String?
    var commentsCount: Int = 0
    var favoritesCount: Int = 0
    var location: String?
    var postImage = PFFile.self
    var favorite: Bool?
    var idString: String?
    
    var postedTimeStamp: NSDate?
    
    var user: NSDictionary?
    var username: String = ""
    var userImageUrl = NSURL()
    
    // for printing purpose only
    var raw_post: PFObject?
    
    override init() {
        super.init()
    }
    
    init(dictionary: PFObject) {
        super.init()
        
        raw_post = dictionary
        
        caption = dictionary["caption"] as? String
        commentsCount = (dictionary["comments_count"] as? Int) ?? 0
        favoritesCount  = (dictionary["favorite_count"] as? Int) ?? 0
        location = dictionary["location"] as? String
        postImage = dictionary["post_image"] as! PFFile
        favorite = dictionary["favorited"] as? Bool
        idString = dictionary["id_str"] as? String

        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            postedTimeStamp = formatter.date(from: timestampString) as NSDate?
        }
        
        // the user associated with the user
        let userDictionary = dictionary["user"] as! NSDictionary
        username = (userDictionary["user_name"] as? String)!
        userImageUrl = NSURL(string: userDictionary["profile_image_url_https"] as! String)!

        
    }
    
    class func getArrayOfPostsFromPFOjects(dictionaries: [PFObject]) -> [Post] {
        var posts: [Post] = []
        for dictionary in dictionaries {
            let post = Post(dictionary: dictionary)
            posts.append(post)
        }
        
        return posts
    }
    
    func printTweetsUser() {
        print("\(String(describing: user))")
    }
    
    func printAll() {
        print("\(String(describing: raw_post))")
    }
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["user"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        // Save object (following function will save the object in Parse asynchronously)
        //post.saveInBackground(block: completion)
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
