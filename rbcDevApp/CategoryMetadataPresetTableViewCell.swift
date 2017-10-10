//
//  CategoryMetadataPresetTableViewCell.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/03.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class CategoryMetadataPresetTableViewCell: UITableViewCell {

    @IBOutlet var numberingLabel:UILabel!
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var formatLabel:UILabel!
    @IBOutlet var unitLabel:UILabel!
    @IBOutlet var deleteLabel:UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
