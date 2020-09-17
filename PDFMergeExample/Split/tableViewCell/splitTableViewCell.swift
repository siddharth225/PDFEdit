//
//  splitTableViewCell.swift
//  PDFMergeExample
//
//  Created by Siddharth on 17/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit

class splitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var txtStartRange: UITextField!
    @IBOutlet weak var txtEndRange: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
