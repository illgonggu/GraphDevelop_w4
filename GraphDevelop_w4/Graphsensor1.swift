import SwiftUI
import Charts
import UIKit
@_exported import Shapes



struct Graphsensor1: View {
    
    let userDefaults = UserDefaults.standard
    @State var doubleQueue1 = Queue<Double>()
    @State var qlist1 = [Double](repeating: 0.0 , count: 50)
    var tlist = 11
    @Binding var setDouble: [Double]
    
    @StateObject var valuePublisher = ValuePublisher()
    //var fileData = ["Temperature,Humidity,Sensor1,Sensor2,Sensor3,Sensor4\n".data(using: .utf8)]
    var body: some View {
        HStack {
            VStack {
                AxisLabels(.vertical, data: (0...6).reversed(), id: \.self) {
                    Text("\($0 * 1000)")
                        .lineSpacing(120)
                        .fontWeight(.bold)
                        .font(Font.system(size: 6))
                        .foregroundColor(.secondary)
                }
                .frame(width: 20)
            }


            VStack {
                Chart(data: doubleQueue1.list)
                    .chartStyle(
                        LineChartStyle(.quadCurve,lineColor: .red, lineWidth: 2)
                    )
                    .padding()
                    .background(
                        GridPattern(horizontalLines: 15 , verticalLines: qlist1.count)
                            .inset(by: 1)
                            .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .onAppear {
                        doubleQueue1.list = userDefaults.object(forKey: "doublequeue1") as? [Double] ?? [Double](repeating: 0.0 , count: 50)
                    }
                //valuePublisher.time
                    .onChange(of:setDouble) { value in
                        self.doubleQueue1.enqueue(setDouble[0]/6000.0)
                        _ = self.doubleQueue1.dequeue()
                        userDefaults.set(doubleQueue1.list, forKey: "doublequeue1")
                        
                        
                        let fileManager = FileManager.default
                        let folderName = "newCSVFolder"
                        let csvFileName = "myCSVFile.csv"

                        // 폴더 생성
                        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let directoryUrl = documentUrl.appendingPathComponent(folderName)
                        let fileUrl = directoryUrl.appendingPathComponent(csvFileName)
//
//                        //var fileData = userDefaults.object(forKey: "fileData") as? String ?? "Temperature,Humidity,Sensor1,Sensor2,Sensor3,Sensor4\n"
//                            //.data(using: .utf8)
                        var fileData = "Temperature,Humidity,Sensor1,Sensor2,Sensor3,Sensor4\n".data(using: .utf8)
                        var Data = "\(setDouble[4]),\(setDouble[5]),\(setDouble[0]),\(setDouble[1]),\(setDouble[2]),\(setDouble[3])\n".data(using: .utf8)
                        fileData?.append(Data!)
                        do {
                            try fileData?.write(to: fileUrl)
                            userDefaults.set(fileData, forKey: "fileData")
                            print("Writing CSV to: \(fileUrl.path)")
                        }
                        catch let error as NSError {
                            print("CSV파일 생성 에러: \(error)")
                        }
//                        var exists = false
                                    
//                        let stream = OutputStream(url: url, append: true)!
//                        let csv = try! CSVWriter(stream: stream)
//
//                        if !exists {
//                            try! fileData?.write(to: fileUrl)
//                            exists = true
//                            print("Writing CSV to: \(fileUrl.path)")
//                        }
//                        try! Data?.write(to: fileUrl)
//                        print("Writing CSV to: \(fileUrl.path)")
                        
//                        let data = [UInt8](csv.configuration.newline.utf8)
//                        csv.stream.write(data, maxLength: data.count)
//
//                        csv.stream.close()
                    }
            }
            .layoutPriority(1)
        }
        .padding()
    }
}

func createCSV() {
    let fileManager = FileManager.default

    let folderName = "newCSVFolder"
    let csvFileName = "myCSVFile.csv"

    // 폴더 생성
    let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let directoryUrl = documentUrl.appendingPathComponent(folderName)
    do {
        try fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true, attributes: nil)
    }
    catch let error as NSError {
        print("폴더 생성 에러: \(error)")
    }

    // csv 파일 생성
    let fileUrl = directoryUrl.appendingPathComponent(csvFileName)
    let fileData = "Temperature,Humidity,Sensor1,Sensor2,Sensor3,Sensor4".data(using: .utf8)
    //var data = "\(setDouble[4]),\(setDouble[5]),\(setDouble[0]),\(setDouble[1]),\(setDouble[2]),\(setDouble[3])"
    do {
        try fileData?.write(to: fileUrl)

        print("Writing CSV to: \(fileUrl.path)")
    }
    catch let error as NSError {
        print("CSV파일 생성 에러: \(error)")
    }
}
