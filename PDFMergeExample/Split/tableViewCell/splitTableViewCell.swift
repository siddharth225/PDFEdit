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
    
    typealias delte = ()->()
    var deleteRecord: delte?
    
    var arrRange: [PDFRange] = []
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData() {
        guard let cell = self.superview?.superview as? splitTableViewCell else {
            return // or fatalError() or whatever
        }
        guard let tableview = self.superview  as? UITableView else {
            return
        }
        
        if let indexPath = tableview.indexPath(for: cell) {
            self.txtStartRange.text = "\(self.arrRange[indexPath.row].startPage)"
            self.txtEndRange.text = "\(self.arrRange[indexPath.row].endRange)"
        }
    }

    @IBAction func btnDeleteRecord(_ sender: UIButton) {
        deleteRecord!()
    }
}

