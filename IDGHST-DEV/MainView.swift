
import SwiftUI

/// 메인 뷰
struct MainView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        // SettingView(viewRouter: viewRouter)
        //ScrollView {
            VStack (spacing: 20) {
                VStack (spacing: 0) {
                    HStack (spacing: 20) {
                        // MARK: - 000
                        Button {
                            viewRouter.currentPage = "IntroView to MainIPOView"
                        } label: {
                            VStack (spacing: 10) {
                                Image("IPOProfile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .background(Color(hex: 0x000000))
                                    .cornerRadius(20)
                                Text("오늘의 공모주")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(hex: 0xFFFFFF))
                                    .lineLimit(1)
                            }
                            .frame(width: 100)
                        }
                    }
                }
            }
            .padding()
        //}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: ViewRouter())
            .preferredColorScheme(.dark)
    }
}
