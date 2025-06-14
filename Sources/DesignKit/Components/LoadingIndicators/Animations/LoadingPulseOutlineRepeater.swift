
import SwiftUI

struct LoadingPulseOutlineRepeater: View {
    @State var isAnimating: Bool = false
    let timing: Double
    
    let maxCounter: Int = 3
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed * 4
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }

    var body: some View {
        ZStack {
            
            ForEach(0..<maxCounter) { index in
                Circle()
                    .stroke(
                        primaryColor.opacity(isAnimating ? 0.0 : 1.0),
                        style: StrokeStyle(lineWidth: isAnimating ? 0.0 : 10.0))
                    .scaleEffect(isAnimating ? 1.0 : 0.0)
                    .animation(
                        Animation.easeOut(duration: timing)
                        .repeatForever(autoreverses: false)
                        .delay(Double(index) * timing / Double(maxCounter) / Double(maxCounter))
                    )
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}

struct LoadingPulseOutlineRepeater_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPreviewView(animation: .pulseOutlineRepeater)
    }
}
