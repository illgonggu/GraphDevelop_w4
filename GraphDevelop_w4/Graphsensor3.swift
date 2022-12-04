import SwiftUI
import Charts
import UIKit
@_exported import Shapes



struct Graphsensor3: View {
    
    let userDefaults = UserDefaults.standard
    @State var doubleQueue3 = Queue<Double>()
    @State var qlist3 = [Double](repeating: 0.0 , count: 50)
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
                Chart(data: doubleQueue3.list)
                    .chartStyle(
                        LineChartStyle(.quadCurve,lineColor: .green, lineWidth: 2)
                    )
                    .padding()
                    .background(
                        GridPattern(horizontalLines: 15 , verticalLines: qlist3.count)
                            .inset(by: 1)
                            .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .onAppear {
                        doubleQueue3.list = userDefaults.object(forKey: "doublequeue3") as? [Double] ?? [Double](repeating: 0.0 , count: 50)
                    }
                    .onChange(of: valuePublisher.time) { value in
                        self.doubleQueue3.enqueue(setDouble[2]/6000.0)
                        _ = self.doubleQueue3.dequeue()
                        userDefaults.set(doubleQueue3.list, forKey: "doublequeue3")
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
