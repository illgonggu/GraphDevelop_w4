//
//  ContentView.swift

import SwiftUI

struct ContentView: View {
    
    @Namespace var animation
    @State var detailShow: Bool = false
    @State var tcpShow: Bool = false
    
    @State var getString : String = "A0000/B0000/C0000/D0000/T000.00/R000.00"
    @State var setString:[String] = ["","","","","",""]
    @State var setDouble:[Double] = [0.0,0.0,0.0,0.0,0.0,0.0]
    
    var body: some View {
//        TcpView()
        NavigationView{
            VStack(alignment: .trailing){
                if !detailShow{
                    NavigationLink(destination: TcpView(getString: $getString,setString: $setString,setDouble: $setDouble)){
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding(.horizontal,20)
                            .padding(.bottom)
                    }//NavigationLink
                }
                VStack{
                    if detailShow {
                        DetailView(animation: animation, detailShow: $detailShow,setDouble: $setDouble)
                    } else {
                        //ChartView()
                        GraphDemo(setDouble: $setDouble)
                            .matchedGeometryEffect(id: "image", in: animation)
                            .frame(width: 380, height: 280)
                            .onTapGesture{
                                withAnimation {
                                    detailShow = true
                                }
                            }
                        ButtonStack(setDouble: $setDouble)
                    }
                }

            }
           
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
