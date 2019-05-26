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
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    func update(post: Post, image: UIImage? = nil) {
        self.post = post
        //self.profileImage =
        //self.userNameLabel =
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
}
