//
//  GraphDevelop_w4App.swift
//  GraphDevelop_w4
//
//  Created by Loopy on 2022/12/04.
//

import SwiftUI

@main
struct GraphDevelop_w4App: App {
    init(){
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if (key != "IP"){
                UserDefaults.standard.removeObject(forKey: key.description)
            }
        }
//        //createCSV()
//        let fileManager = FileManager.default
//        let folderName = "newCSVFolder"
//        let csvFileName = "myCSVFile.csv"
//
//        // 폴더 생성
//        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let directoryUrl = documentUrl.appendingPathComponent(folderName)
//        let fileUrl = directoryUrl.appendingPathComponent(csvFileName)
//        do {
//            try fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true, attributes: nil)
//        }
//        catch let error as NSError {
//            print("폴더 생성 에러: \(error)")
//        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
