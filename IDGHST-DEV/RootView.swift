
import SwiftUI

/// 루트 뷰: 앱 라이프 사이클 조절용
/// - viewRouter.currentPage = "???"
///   - IntroView : 인트로
///   - MainView : 메인뷰
struct RootView: View {
    
    @AppStorage("fontSize") var fontSize: Double = 24.0
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State var animate: Bool = false
    
    var body: some View {
        
        VStack {
            
            if viewRouter.currentPage == "MainView" {
                MainView(viewRouter: viewRouter)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if viewRouter.currentPage.components(separatedBy: " to ")[0] == "IntroView" {
                IntroView(viewRouter: viewRouter)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if viewRouter.currentPage == "MainIPOView" {
                MainIPOView(viewRouter: viewRouter)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if viewRouter.currentPage == "TestPageView" {
                TestPageView(viewRouter: viewRouter)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewRouter: ViewRouter())
            .preferredColorScheme(.dark)
    }
}
