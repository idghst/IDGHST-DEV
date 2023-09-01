
import SwiftUI

/// 인트로뷰
/// - 1초 후 메인뷰로 이동
struct IntroView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    @AppStorage("userProfileUrl") var userProfileUrl: String = ""
    
    @State private var isPreview: Bool = false // true: 프리뷰 / false: 실제뷰
    
    @State private var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
            VStack {
                if viewRouter.currentPage != "MainView" {
                    if viewRouter.currentPage == "MainIPOView" || viewRouter.currentPage.components(separatedBy: " to ")[1] == "MainIPOView" {
                        Image("IPOProfile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .frame(width: 100)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)
            
            Spacer()
            
            VStack (spacing: 0) {
                if viewRouter.currentPage != "MainView" {
                    if viewRouter.currentPage == "MainIPOView" || viewRouter.currentPage.components(separatedBy: " to ")[1] == "MainIPOView" {
                        Text("오늘의 공모주")
                    }
                }
            }
            .font(.system(size: 24, weight: .black))
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if viewRouter.currentPage != "MainView" {
                    self.viewRouter.currentPage = viewRouter.currentPage.components(separatedBy: " to ")[1]
                }
            })
        }
        
        
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(viewRouter: ViewRouter())
            .preferredColorScheme(.dark)
    }
}
