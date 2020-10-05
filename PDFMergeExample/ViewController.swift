//
//  ViewController.swift
//  PDFMergeExample
//
//  Created by Siddharth on 09/09/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {
    @IBOutlet weak var viewPDF: PDFView!
    @IBOutlet weak var thumbnailView: PDFThumbnailView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MergeThePDF()
    }
}
extension ViewController {
    func MergeThePDF() {
        let mainDoc: PDFDocument = PDFDocument()
        guard let path1 = Bundle.main.url(forResource: "1", withExtension: "pdf") else { return }
        guard let path2 = Bundle.main.url(forResource: "2", withExtension: "pdf") else { return }
        guard let path3 = Bundle.main.url(forResource: "3", withExtension: "pdf") else { return }
        
        let arrLinks: [URL] = [path1,path2,path3]
        var totalpage: Int = mainDoc.pageCount
        for linkIndex in 0..<arrLinks.count {
            let document1: PDFDocument = PDFDocument(url: arrLinks[linkIndex])!
            totalpage =  mainDoc.pageCount
            for index in 0..<document1.pageCount {
                mainDoc.insert(document1.page(at: index)!, at: totalpage+index)
            }
        }
        let matches: [PDFSelection] = mainDoc.findString("A Simple PDF File", withOptions: .caseInsensitive)
        print(matches)
        viewPDF.document = mainDoc
        viewPDF.displayMode = .singlePage
        viewPDF.autoScales = true
        viewPDF.displayDirection = .vertical
        thumbnailView.thumbnailSize = CGSize(width: 50, height: 50)
        thumbnailView.layoutMode = .horizontal
        thumbnailView.pdfView = viewPDF
    }
}

