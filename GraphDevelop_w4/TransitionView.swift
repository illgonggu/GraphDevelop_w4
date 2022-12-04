//
//  TransitionView.swift

import SwiftUI

struct TransitionView: View{
    
    @Binding var transitionView: Bool
    @Binding var setDouble: [Double]
    var body: some View{
        VStack{
            Button("버튼"){
                transitionView.toggle()
            }
            .padding(.leading)
            .rotationEffect(Angle(degrees: 90))
            Spacer()
        }
        if transitionView{
            //RoundedRectangle(cornerRadius: 20)
            TransitionStack(setDouble: $setDouble)
                .rotationEffect(Angle(degrees: 90))
                .frame(height: UIScreen.main.bounds.height*0.5)
                .transition(.move(edge: .bottom))
                .animation(.easeIn)
        }
    }
}
