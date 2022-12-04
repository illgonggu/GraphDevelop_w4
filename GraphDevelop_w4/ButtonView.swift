//  ButtonView.swift


import SwiftUI

struct ButtonView: View{
    
    var title : String
    var value : String
    var bgColor : Color
    
    var body: some View{
        Button(action: {
            print("1번 버튼 클릭됨")
        }){
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size:15))
                    .fontWeight(.black)
                Text(value)
                    .font(.system(size:20))
                    .fontWeight(.black)
                    .frame(width: 150, height: 70)
                    .foregroundColor(Color.white)
                    .background(bgColor)
            }
            
        }
        
}
    
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "온도",value: "1", bgColor: Color.yellow)
    }
}
