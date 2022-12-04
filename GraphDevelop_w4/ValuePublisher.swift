//  ValuePublisher.swift


import Foundation


class ValuePublisher: ObservableObject {
   
    @Published var time: Int = UserDefaults.standard.integer(forKey: "ValuePub")

    init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            //createCSV()
            self.time += 1
        }
    }
}


public func convertTimeToFitText(time: Int) -> String {
    // 초와 분을 나눈다.
    let minute = time / 60
    let sec = time % 60
       
    // 1분이 넘는 경우
    if minute > 0 {
      return "0\(minute):\(sec < 10 ? "0\(sec)" : "\(sec)")"
           
    // 1 분이 넘지 않는 경우
    } else {
      return "00:\(sec < 10 ? "0\(sec)" : "\(sec)")"
       }
}

struct Queue<T>{
    var list = [T]()
    
    mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    mutating func dequeue() -> T? {
        if !list.isEmpty {
            return list.removeFirst()
        } else {
            return nil
        }
    }
    
    func peek() -> T? {
        if !list.isEmpty {
            return list[0]
        } else {
            return nil
        }
    }
}
