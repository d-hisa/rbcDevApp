//
//  ContentMetadataTableViewCell.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/27.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentMetadataTableViewCell: UITableViewCell {

    @IBOutlet var textDataLabel: UILabel!
    @IBOutlet var unitDataLabel: UILabel!
    @IBOutlet var imageDataImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
