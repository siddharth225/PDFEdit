//
//  SplitViewController.swift
//  PDFMergeExample
//
//  Created by Siddharth on 16/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit
import PDFKit

struct PDFRange {
    var startPage: Int = 0
    var endRange: Int = 1
}

class SplitViewController: UIViewController {

    @IBOutlet weak var tblViewRange: UITableView!
    @IBOutlet weak var pdfView: PDFView!
    var arrRange: [PDFRange] = []
    var document: PDFDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path2 = Bundle.main.url(forResource: "2", withExtension: "pdf") else { return }
        document = PDFDocument(url: path2)
        arrRange.append(PDFRange(startPage: 1, endRange: 2))
        pdfView.document = document
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
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
        if arrRange.count<document!.pageCount {
            arrRange.append(PDFRange(startPage: arrRange.last!.endRange<document!.pageCount ? arrRange.last!.endRange+1 : arrRange.last!.endRange, endRange: document!.pageCount))
        } else {
            
        }
        self.tblViewRange.reloadData()
    }
}
extension SplitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRange.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: splitTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellSplit") as! splitTableViewCell
//        cell.txtStartRange.text = "\(self.arrRange[indexPath.row].startPage)"
//        cell.txtEndRange.text = "\(self.arrRange[indexPath.row].endRange)"
        cell.loadData()
        cell.deleteRecord = {
            if indexPath.row != 0 {
                self.arrRange.remove(at: indexPath.row)
                self.tblViewRange.reloadData()
            }
        }
        return cell
    }
}
