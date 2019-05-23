//
//  CircularImageView.swift
//  Gramming
//
//  Created by SB on 5/21/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
    }
}
