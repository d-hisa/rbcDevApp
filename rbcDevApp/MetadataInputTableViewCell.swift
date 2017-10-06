//
//  MetadataInputTableViewCell.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MetadataInputTableViewCell: UITableViewCell {

    @IBOutlet var metadataTitleLabel:UILabel!
    @IBOutlet var elementTitleLabel:UILabel!
    @IBOutlet var elementLabel:UILabel!
    @IBOutlet var unitTitleLabel:UILabel!
    @IBOutlet var unitLabel:UILabel!
    @IBOutlet var metaImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
