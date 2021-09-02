//
//  MediationTableViewCell.swift
//  TheGrow
//
//  Created by Adeel on 06/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class MediationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var ivImage:UIImageView!
    @IBOutlet weak var lblStartTime:UILabel!
    @IBOutlet weak var lblEndTime:UILabel!
    @IBOutlet weak var sInterval:UISlider!

    
    weak var delegate: BtnDelegateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sInterval.setThumbImage( #imageLiteral(resourceName: "thumb"), for: .normal)

        sInterval.setThumbImage( #imageLiteral(resourceName: "thumb"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func PlayBtn(_ sender: UIButton) {
        self.delegate?.buttonTapped(cell: self)
    }
    
    
    
    
    
}
