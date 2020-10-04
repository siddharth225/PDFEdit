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
        guard let filePath = self.append(toPath: directory, withPathComponent: fileName) else {
            return
        }
        do {
            try text.write(to: filePath, options: .atomic)
        } catch {
            print("Error", error)
            return
        }
        
        print("Save successful")
    }
    private func append(toPath path: String, withPathComponent pathComponent: String) -> URL? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            return pathURL
        }
        
        return nil
    }
}


