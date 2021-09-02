//
//  ExerciseTableViewCell.swift
//  TheGrow
//
//  Created by Adeel on 06/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    @IBOutlet weak var ivImage:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
