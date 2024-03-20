import SwiftUI

struct Config {
    var expand: Bool {
        expandToTop || expandToBottom
    }
    var expandToBottom: Bool = false
    var expandToTop: Bool = false
    var progress: CGFloat = 0
    var lastProgress: CGFloat = 0
}

struct ContentView: View {
    @State var config: Config = .init()
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            
            BackgroundGradient()
                .blur(radius: 50)
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(0.1)
                )
            
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(.white)
                                .scaleEffect(y: config.progress, anchor: .bottom)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    
                }
                .gesture (
                    DragGesture().onChanged({ value in
                        let startLocation = value.startLocation.y
                        let currentLocation = value.location.y
                        let offset = startLocation - currentLocation
                        var progress = (offset / size.height) + config.lastProgress
                        if progress < 0 {
                            withAnimation {
                                config.expandToBottom = true
                            }
                        } else {
                            withAnimation {
                                config.expandToBottom = false
                            }
                        }
                        if progress > 1 {
                            withAnimation {
                                config.expandToTop = true
                            }
                        } else {
                            withAnimation {
                                config.expandToTop = false
                            }
                        }
                        
                        progress = max(0, progress)
                        progress = min(1, progress)
                        config.progress = progress
                    }).onEnded {_ in
                        withAnimation {
                            config.expandToTop = false
                            config.expandToBottom = false
                            config.lastProgress = config.progress
                        }
                    }
                )
            }
            .frame(width: config.expand ? 85 : 90, height: config.expand ? 220 : 210)
            .offset(y: config.expandToBottom ? 20 : 0)
            .offset(y: config.expandToTop ? -20 : 0)
        }
    }
}

#Preview {
    ContentView()
}
