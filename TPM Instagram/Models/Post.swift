//
//  Post.swift
//  TPM Instagram
//
//  Created by Samman Thapa on 1/5/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import UIKit

import Parse

class Post: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    var caption: String?
    var commentsCount: Int = 0
    var favoritesCount: Int = 0
    var location: String?
    var postImageUrl = NSURL()
    var favorite: Bool?
    var idString: String?
    
    var postedTimeStamp: NSDate?
    
    var userDictionary: NSDictionary?
    var username: String = ""
    var userImageUrl = NSURL()
    
    // for printing purpose only
    var raw_post: PFObject?
    
    init(dictionary: PFObject) {
        super.init()
        
        raw_post = dictionary
        
        caption = dictionary["caption"] as? String
        commentsCount = (dictionary["comments_count"] as? Int) ?? 0
        favoritesCount  = (dictionary["favorite_count"] as? Int) ?? 0
        location = dictionary["location"] as? String
        postImageUrl = NSURL(string: dictionary["post_image_url"] as! String)!
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
        print("\(String(describing: userDictionary))")
    }
    
    func printAll() {
        print("\(String(describing: raw_post))")
    }

}
