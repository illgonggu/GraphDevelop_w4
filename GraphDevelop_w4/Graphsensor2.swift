import SwiftUI
import Charts
import UIKit
@_exported import Shapes



struct Graphsensor2: View {
    
    let userDefaults = UserDefaults.standard
    @State var doubleQueue2 = Queue<Double>()
    @State var qlist2 = [Double](repeating: 0.0 , count: 50)
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
                Chart(data: doubleQueue2.list)
                    .chartStyle(
                        LineChartStyle(.quadCurve,lineColor: .yellow, lineWidth: 2)
                    )
                    .padding()
                    .background(
                        GridPattern(horizontalLines: 15 , verticalLines: qlist2.count)
                            .inset(by: 1)
                            .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .onAppear {
                        doubleQueue2.list = userDefaults.object(forKey: "doublequeue2") as? [Double] ?? [Double](repeating: 0.0 , count: 50)
                    }
                    .onChange(of: valuePublisher.time) { value in
                        self.doubleQueue2.enqueue(setDouble[1]/6000.0)
                        _ = self.doubleQueue2.dequeue()
                        userDefaults.set(doubleQueue2.list, forKey: "doublequeue2")
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
