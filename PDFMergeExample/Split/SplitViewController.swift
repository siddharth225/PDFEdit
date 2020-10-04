//
//  SplitViewController.swift
//  PDFMergeExample
//
//  Created by Siddharth on 16/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit
import PDFKit

class PDFRange {
    var startPage: Int = 0
    var endRange: Int = 1
    init(startPage: Int,endRange: Int) {
       self.startPage = startPage
       self.endRange = endRange
    }
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

   
    
}
extension SplitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRange.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: splitTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellSplit") as! splitTableViewCell
        cell.txtStartRange.text = "\(self.arrRange[indexPath.row].startPage)"
        cell.txtEndRange.text = "\(self.arrRange[indexPath.row].endRange)"
        cell.txtStartRange.tag = indexPath.row
        cell.txtEndRange.tag = indexPath.row
        cell.loadData()
        cell.deleteRecord = {
            if indexPath.row != 0 {
                self.arrRange.remove(at: indexPath.row)
                self.tblViewRange.reloadData()
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}
extension SplitViewController {
    @IBAction func btnTappedAdd(_ sender: UIButton) {
        if arrRange.count<document!.pageCount {
            arrRange.append(PDFRange(startPage: arrRange.last!.endRange<document!.pageCount ? arrRange.last!.endRange+1 : arrRange.last!.endRange, endRange: document!.pageCount))
        }
        self.tblViewRange.reloadData()
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        self.view.endEditing(true)
        if let folder = common.shared.createFolder(folderName: "PDF_1") as? URL {
            print(folder)
            _ = self.arrRange.map({self.writePDF(range: $0)})
        }
    }
    func writePDF(range: PDFRange)  {
        let documentWrite: PDFDocument = PDFDocument()
        var index: Int = 0
        for linkIndex in (range.startPage-1)..<range.endRange {
            documentWrite.insert(document!.page(at: linkIndex)!, at: index)
            index += 1
        }
        common.shared.save(text: documentWrite.dataRepresentation()!, toDirectory: "PDF_1", withFileName: "Range_\(range.startPage)_\(range.endRange).pdf")
    }
}
extension SplitViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(document!.pageCount)
        if !string.isEmpty {
            if range ==  NSRange(location: 0, length: 0) {
                if string == " " || Int(string) == 0 {
                   return false
                }
            }
            return !(Int(string)!>document!.pageCount)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index: Int = textField.tag
        if let cell = self.tblViewRange.cellForRow(at: IndexPath(row: index, section: 0)) as? splitTableViewCell {
            if cell.txtStartRange == textField {
                var range = self.arrRange[textField.tag]
                range.startPage = Int(textField.text!)!
            } else {
                var range = self.arrRange[textField.tag]
                range.endRange = Int(textField.text!)!
            }
        }
    }
}
