//
//  NewsTableViewCell.swift
//  NMCNews(1)
//
//  Created by Harun Fernando on 18/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descNews: UILabel!
    @IBOutlet weak var userid: UILabel!
    @IBOutlet weak var newsid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
