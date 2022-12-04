import SwiftUI
import Charts
import UIKit
@_exported import Shapes



struct GraphDemo: View {
    
    let userDefaults = UserDefaults.standard
    
    @Binding var setDouble: [Double]
    
    var body: some View {
        ZStack{
            Graphsensor1(setDouble: $setDouble)
            Graphsensor2(setDouble: $setDouble)
            Graphsensor3(setDouble: $setDouble)
            Graphsensor4(setDouble: $setDouble)
        }
    }
}

//struct GraphDemo_Previews: PreviewProvider {
//    @Binding var setDouble: [Double]
//    static var previews: some View {
//        GraphDemo()
//    }
//}
