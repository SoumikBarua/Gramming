//
//  Post.swift
//  Gramming
//
//  Created by SB on 5/24/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit
import Firebase

class Post {
    
    // MARK: - Properties
    
    private var _caption: String!
    private var _imageURL: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    
    var caption: String {
        return _caption
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageURL: String, likes: Int) {
        self._caption = caption
        self._imageURL = imageURL
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let imageURL = postData["imageURL"] as? String {
            self._imageURL = imageURL
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataService.dataService.REF_POSTS.child(_postKey)
    }
    
    func updateLikes(addLike: Bool) {
        if addLike {
            _likes += 1
        } else {
            _likes -= 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
}
