
import SwiftUI


struct TcpView: View {
     
    let userDefaults = UserDefaults.standard
    let socket = TcpSocket()
    //socket.connect(host: "118.34.167.155", port: 5552)
    //.connect(host: "118.34.167.155", port: 5552)
    @Binding var getString :String
    @Binding var setString :[String]
    @Binding var setDouble :[Double]
//    @StateObject var valuePublisher = ValuePublisher()

    @State private var ip: String = ""
    
    var body: some View {
        VStack {
            Text("TCP/IP 소켓 연결")
                .font(.system(size: 15))
                .imageScale(.large)
                .padding(5)
            Image(systemName: "globe")
                .font(.system(size: 30))
                .imageScale(.large)
                .foregroundColor(.accentColor)
            HStack{
                Text("IP")
                TextField("", text: $ip)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("연결"){
                    socket.connect(host: ip, port: 9999)
                    let query = "HELLO SWIFT SOCKET!"
                    let dataQuery = query.data(using: String.Encoding.utf8, allowLossyConversion: true)
//                    let sentCount = socket.send(data: dataQuery!)
    //                let sentCount = socket.send(data: query)
//                    print("sentCount : \(sentCount)")

                    let buffersize = 1024
                
                   
    //                getString = String(bytes: chunk, encoding: String.Encoding.utf8)!
    //                print("received : \(getString)")
    //
                    let chunk = socket.recv(buffersize: buffersize)
                    if(chunk.count > 0){
                        getString = String(bytes: chunk, encoding: String.Encoding.utf8)!
                        print("received : \(getString)")
                    }
                }
                .onAppear{
                    ip = userDefaults.string(forKey: "IP") ?? ""
                }
                .onChange(of: getString) { getstring in
                    setString = self.getString.components(separatedBy: "/")
                    setString[0].remove(at: setString[0].startIndex)
                    setString[1].remove(at: setString[1].startIndex)
                    setString[2].remove(at: setString[2].startIndex)
                    setString[3].remove(at: setString[3].startIndex)
                    setString[4].remove(at: setString[4].startIndex)
                    setString[5].remove(at: setString[5].startIndex)
                    
                    setDouble[0] = Double(setString[0]) ?? 0.0
                    setDouble[1] = Double(setString[1]) ?? 0.0
                    setDouble[2] = Double(setString[2]) ?? 0.0
                    setDouble[3] = Double(setString[3]) ?? 0.0
                    setDouble[4] = Double(setString[4]) ?? 0.0
                    setDouble[5] = Double(setString[5]) ?? 0.0
                }
                .onChange(of: ip) { p in
                    userDefaults.set(ip, forKey: "IP")
                }
                .onChange(of:socket.portCheck){ pc in
                    socket.portCheck = self.socket.portCheck
                    print("\(socket.portCheck)")
                }
            }//HStack
            .padding(.top,10)
            .padding(.horizontal,50)
            if socket.portCheck {
                Text("Connect")
                    .font(.system(size: 10))
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            else {
                Text("Disconnect")
                    .font(.system(size: 10))
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .padding(.bottom,100)
    }
}









