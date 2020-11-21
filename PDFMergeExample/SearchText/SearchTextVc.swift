//
//  SearchTextVc.swift
//  PDFMergeExample
//
//  Created by Siddharth on 05/10/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit
import PDFKit


class PDFcollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pdfView: PDFView!
}
class SearchTextVc: UIViewController {
    
    @IBOutlet weak var colletioviewSearch: UICollectionView!
    var pdfDocument: PDFDocument = PDFDocument()
    
    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path2 = Bundle.main.url(forResource: "2", withExtension: "pdf") else { return }
        self.pdfDocument = PDFDocument(url: path2)!
        self.colletioviewSearch.reloadData()
        txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        print(sender.text!)
        if !sender.text!.isEmpty {
            let matches: [PDFSelection] = self.pdfDocument.findString(sender.text!, withOptions: .caseInsensitive)
            print(matches)
            if matches.count>0 {
                if matches[0].pages.count>0 {
                    let page: PDFPage = matches[0].pages[0]
                    print(page.string)
                    
                }
            }
        }
    }
    
}
extension SearchTextVc :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocument.pageCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PDFcollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSearch", for: indexPath) as! PDFcollectionViewCell
        cell.pdfView.document = pdfDocument
        cell.pdfView.go(to: pdfDocument.page(at: indexPath.row)!)
        cell.pdfView.displayMode = .singlePage
        cell.pdfView.autoScales = true
        return cell
    }
}
extension SearchTextVc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.colletioviewSearch.frame.width/2)-10, height: 220)
    }
}
