//
//  SideMenuTableViewCell.swift
//  TastyBox
//
//  Created by Adeel on 14/04/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var dotView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
