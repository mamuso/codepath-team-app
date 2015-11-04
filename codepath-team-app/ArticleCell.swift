//
//  ArticleCell.swift
//  codepath-team-app
//
//  Created by Angel Steger on 10/29/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    //Create outlets for content types
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var readtimeLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    var pocketItemId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
