//
//  FeedTableViewCell.swift
//  Gramming
//
//  Created by SB on 5/22/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class FeedTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var heartImage: UIImageView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var caption: UITextView!
    @IBOutlet var likesCountLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
}
