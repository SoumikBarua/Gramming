//
//  FeedTableViewCell.swift
//  Gramming
//
//  Created by SB on 5/22/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit
import Firebase

class FeedTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var heartImage: UIImageView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var caption: UITextView!
    @IBOutlet var likesCountLabel: UILabel!
    
    var post: Post!
    var likesRef: DatabaseReference!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        heartImage.addGestureRecognizer(tap)
        heartImage.isUserInteractionEnabled = true
    }
    
    func update(post: Post, image: UIImage? = nil) {
        self.post = post
        likesRef = DataService.dataService.REF_CURRENT_USER.child("likes").child(post.postKey)
        //self.profileImage =
        //self.userNameLabel =
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.heartImage.image = UIImage(named: "empty-heart")
            } else {
                self.heartImage.image = UIImage(named: "filled-heart")
            }
        })
        
        //self.heartImage =
        if let imageExists = image {
            self.postImage.image = imageExists
        } else {
            let ref = Storage.storage().reference(forURL: post.imageURL)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from Firebase storage!: \(String(describing: error))")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imageData = data {
                        if let image = UIImage(data: imageData) {
                            self.postImage.image = image
                            FeedViewController.imageCache.setObject(image, forKey: post.imageURL as NSString)
                        }
                    }
                }
            })
        }
            
        self.caption.text = post.caption
        self.likesCountLabel.text = "\(post.likes)"
    }
    
    @objc func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.heartImage.image = UIImage(named: "filled-heart")
                self.post.updateLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.heartImage.image = UIImage(named: "empty-heart")
                self.post.updateLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }
}
