import SwiftUI
import Charts
import UIKit
@_exported import Shapes



struct Graphsensor4: View {
    
    let userDefaults = UserDefaults.standard
    @State var doubleQueue4 = Queue<Double>()
    @State var qlist4 = [Double](repeating: 0.0 , count: 50)
    var tlist = 11
    @Binding var setDouble: [Double]
    
    @StateObject var valuePublisher = ValuePublisher()
    
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
                Chart(data: doubleQueue4.list)
                    .chartStyle(
                        LineChartStyle(.quadCurve,lineColor: .blue, lineWidth: 2)
                    )
                    .padding()
                    .background(
                        GridPattern(horizontalLines: 15 , verticalLines: qlist4.count)
                            .inset(by: 1)
                            .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .onAppear {
                        doubleQueue4.list = userDefaults.object(forKey: "doublequeue4") as? [Double] ?? [Double](repeating: 0.0 , count: 50)
                    }
                    .onChange(of: valuePublisher.time) { value in
                        self.doubleQueue4.enqueue(setDouble[3]/6000.0)
                        _ = self.doubleQueue4.dequeue()
                        userDefaults.set(doubleQueue4.list, forKey: "doublequeue4")
                    }
            }
            .layoutPriority(1)
        }
        .padding()
    }
}

//struct GraphDemo_Previews: PreviewProvider {
//    @Binding var setDouble: [Double]
//    static var previews: some View {
//        GraphDemo()
//    }
//}
