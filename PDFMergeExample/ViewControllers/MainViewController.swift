//
//  MainViewController.swift
//  PDFMergeExample
//
//  Created by Siddharth on 15/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit

enum PDFDemo: Int {
    case Merge = 0, Edit, Split, SearchText
    
    var caseText: String {
        return String(describing: self)
    }
    var segue: String {
        switch self {
        case .Merge:
            return "segueMerge"
        case .Split:
            return "segueSplit"
        default:
            return "segueSplit"
        }
    }
}

class cellData: UITableViewCell {
    @IBOutlet weak var lblData: UILabel!
    
}
class MainViewController: UIViewController {
    @IBOutlet weak var tblData: UITableView!
    
    var arrData:[PDFDemo] = [.Merge, .Edit,.Split, .SearchText]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblData.reloadData()
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

}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: cellData = tableView.dequeueReusableCell(withIdentifier: "cellData") as! cellData
        cell.lblData.text = self.arrData[indexPath.row].caseText
        return cell
    }
}
extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: self.arrData[indexPath.row].segue, sender: nil)
    }
}
