//
//  TvShowCellController.swift
//  ViewIt
//
//  Created by Santiago Castaño M on 7/22/16.
//  Copyright © 2016 Santiago Castano. All rights reserved.
//

import UIKit

class TvShowCellController: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var followBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
