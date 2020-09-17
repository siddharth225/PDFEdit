//
//  SplitViewController.swift
//  PDFMergeExample
//
//  Created by Siddharth on 16/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit

struct PDFRange {
    var startPage: Int = 0
    var endRange: Int = 1
}

class SplitViewController: UIViewController {

    @IBOutlet weak var tblViewRange: UITableView!
    var arrRange: [PDFRange] = [PDFRange(startPage: 0, endRange: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblViewRange.reloadData()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnTappedAdd(_ sender: UIButton) {
        arrRange.append(PDFRange(startPage: arrRange.last!.startPage+1, endRange: arrRange.last!.startPage+2))
        self.tblViewRange.reloadData()
    }
}
extension SplitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRange.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: splitTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellSplit") as! splitTableViewCell
        cell.txtStartRange.text = "\(self.arrRange[indexPath.row].startPage)"
        cell.txtEndRange.text = "\(self.arrRange[indexPath.row].endRange)"
        return cell
    }
}
