//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Debiprasad Dash on 30/07/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var youAvatar: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBOutlet weak var meAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
