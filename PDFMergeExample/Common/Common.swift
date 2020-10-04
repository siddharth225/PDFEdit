//
//  File.swift
//  PDFMergeExample
//
//  Created by Siddharth on 04/10/20.
//  Copyright © 2020 Siddharth. All rights reserved.
//

import Foundation


class common: NSObject {
    static let shared = common()
    
    func createFolder(folderName: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent(folderName)
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
        return dataPath
    }
    func save(text: Data, toDirectory directory: String, withFileName fileName: String) {
        if let filePath = getDocumentsDirectory().appendingPathComponent(directory).appendingPathComponent(fileName) as? URL {
            print(filePath.absoluteString)
            do {
                print(filePath.absoluteString)
                try text.write(to: filePath, options: .atomic)
            } catch {
                print("Error", error)
                return
            }
            print("Save successful")
        }
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
//    func getA4Compress(pdfData:Data,url: URL) -> Data {
//        let pdf = CGPDFDocument(url as NSURL)
//        let page = (pdf?.page(at: 1))!
//        let frame = page.getBoxRect(.mediaBox)
//
//        if frame.width >= 595.2 {
//
//            let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
//            let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
//            let data = renderer.pdfData { (context) in
//
//                for i in 1...pdf!.numberOfPages {
//                    context.beginPage()
//                    let page = (pdf?.page(at: i))!
//                    let pageFrame = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
//                    context.cgContext.saveGState()
//                    context.cgContext.scaleBy(x: 1, y: -1)
//                    context.cgContext.translateBy(x: 0, y: -pageFrame.size.height)
//                    context.cgContext.concatenate(page.getDrawingTransform(.mediaBox, rect: pageFrame, rotate: 0, preserveAspectRatio: true))
//                    context.cgContext.drawPDFPage(page)
//                    context.cgContext.restoreGState()
//                }
//            }
//            return data
//        }
//        return pdfData
//    }
}


