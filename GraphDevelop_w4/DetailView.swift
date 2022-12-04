//  DetailView.swift

import SwiftUI

struct DetailView: View{
    
    @State var transitionView: Bool = false
    var animation : Namespace.ID
    @Binding var detailShow: Bool
    @Binding var setDouble : [Double]
    var body: some View{
        ZStack(alignment: .leading){
            TransitionView(transitionView: $transitionView,setDouble: $setDouble)
                .zIndex(3)
            Spacer()
//            ChartView()
            GraphDemo(setDouble: $setDouble)
                //.clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .matchedGeometryEffect(id: "image", in: animation)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .rotationEffect(Angle(degrees: 90))
                .overlay {
                    VStack {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.top,50)
                            .padding(.leading,-180)
                            .opacity(detailShow ? 1 : 0)
                            .onTapGesture {
                                withAnimation {
                                    detailShow = false
                                }
                            }
                        Spacer()
                    }
                }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
