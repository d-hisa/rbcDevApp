//
//  ContntsListTableViewCell.swift
//  rbcDevApp
//
//  Created by nttr on 2017/09/12.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ContentsListTableViewCell: UITableViewCell {

    @IBOutlet var mainText: UILabel!
    @IBOutlet var subText: UILabel!
    @IBOutlet var contentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
