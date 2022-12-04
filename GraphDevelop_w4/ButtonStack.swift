//
//  ButtonStack.swift

import SwiftUI
import Foundation
struct ButtonStack: View{
//    @StateObject var valuePublisher = ValuePublisher()
    @Binding var setDouble :[Double]
    let userDefaults = UserDefaults.standard
    var body: some View{
        VStack{
            HStack{
                ButtonView(title:"Temperature",value: "\(String(format: "%.2f", setDouble[4])) ℃", bgColor: Color.black)
                ButtonView(title:"Humidity",value: "\(String(format: "%.2f", setDouble[5])) %RH", bgColor: Color.black)
            }
            .padding(.bottom,10)
            HStack{
                ButtonView(title:"Sensor1",value: "\(String(format: "%4.0f", setDouble[0])) mV", bgColor: Color.gray)
                ButtonView(title:"Sensor2",value: "\(String(format: "%4.0f", setDouble[1])) mV", bgColor: Color.gray)
            }
            HStack{
                ButtonView(title:"Sensor3",value: "\(String(format: "%4.0f", setDouble[2])) mV", bgColor: Color.gray)
                ButtonView(title:"Sensor4",value: "\(String(format: "%4.0f", setDouble[3])) mV", bgColor: Color.gray)
            }
//            .padding(.bottom,50)
            .onAppear{
                setDouble[4] = userDefaults.value(forKey: "temperature") as? Double ?? 0.0
                setDouble[5] = userDefaults.value(forKey: "humidity") as? Double ?? 0.0
                setDouble[0] = userDefaults.value(forKey: "sensor1") as? Double ?? 0.0
                setDouble[1] = userDefaults.value(forKey: "sensor2") as? Double ?? 0.0
                setDouble[2] = userDefaults.value(forKey: "sensor3") as? Double ?? 0.0
                setDouble[3] = userDefaults.value(forKey: "sensor4") as? Double ?? 0.0
            }
            .onChange(of: setDouble) { value in
                userDefaults.set(setDouble[4], forKey: "temperature")
                userDefaults.set(setDouble[5], forKey: "humidity")
                userDefaults.set(setDouble[0], forKey: "sensor1")
                userDefaults.set(setDouble[1], forKey: "sensor2")
                userDefaults.set(setDouble[2], forKey: "sensor3")
                userDefaults.set(setDouble[3], forKey: "sensor4")
            }
        }
    }
}
//struct ButtonStack_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonStack()
//    }
//}
