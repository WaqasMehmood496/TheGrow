//
//  EducationTableViewCell.swift
//  TheGrow
//
//  Created by Adeel on 07/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import FSPagerView
class EducationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    //@IBOutlet weak var ivImage:UIImageView!
    @IBOutlet weak var lbltime:UILabel!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.automaticSlidingInterval = 5.0
            pagerView.isInfinite = true
            pagerView.transformer = FSPagerViewTransformer(type: .depth)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
