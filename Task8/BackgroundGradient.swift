import SwiftUI

struct BackgroundGradient: View {
    @State var startAngle = 0
    @State var endAngle = 360
    
    let timer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
    let colors = [Color(#colorLiteral(red: 0.8586297035, green: 0.875579536, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.9019607843, green: 0.5019607843, blue: 0.2196078431, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.5611200333, green: 0, blue: 0.2354234457, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.9019607843, green: 0.5019607843, blue: 0.2196078431, alpha: 1)), Color(#colorLiteral(red: 0.8586297035, green: 0.875579536, blue: 0, alpha: 1))]
    
    var body: some View {
        GeometryReader { geometry in
            AngularGradient(gradient: Gradient(colors: colors), center: .center, startAngle: .degrees(Double(startAngle)), endAngle: .degrees(Double(endAngle)) )
                .edgesIgnoringSafeArea(.all)
                .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), value: startAngle)
                .onReceive(timer, perform: { _ in
                    self.startAngle += 10
                    self.endAngle += 10
                })
                .transition(AnyTransition.scale.animation(.default))
                .scaleEffect(1.1)
                .scaledToFill()
        }
    }
}
