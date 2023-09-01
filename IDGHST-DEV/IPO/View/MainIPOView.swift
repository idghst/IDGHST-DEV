
import SwiftUI

struct MainIPOView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var selectedIndex: Int = 0
    
    @State private var scrollTopToday = false
    
    @State private var scrollTopTot = false
    
    //    @State var selectedTab = 0
    //
    //    @AppStorage("userNickname") var userNickname: String = "닉네임"
    //    @AppStorage("userProfileUrl") var userProfileUrl: String = ""
    //
    //    @State private var scrollToTopHome: Bool = false
    //    @State private var showingDetailHome = false
    //
    //    @State private var showingDetail = false
    //    @State private var scrollToTop: Bool = false
    //
    //    @State var presentSideMenu = false
    
    
    
    var body: some View {
        
        NavigationView {
            
            TabView(selection: $selectedIndex) {
                
                VStack (spacing: 0) {
                    
                    HStack {
                        
                        if selectedIndex == 0 {
                            Image("IPOProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .cornerRadius(32)
                        }
                        
                        VStack {
                            if selectedIndex == 0 {
                                Text("오늘의 공모주")
                            }
                            else if selectedIndex == 1 {
                                Text("전체")
                            }
                            else if selectedIndex == 2 {
                                Text("기타")
                            }
                            else if selectedIndex == 3 {
                                Text("설정")
                            }
                        }
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(Color(hex: 0xFFFFFF))
                        
                        Spacer()
                        
                        HStack {
                            
                        }
                    }
                    .padding()
                    
                    if selectedIndex == 0 {
                        IpoTodayView(scrollTopToday: $scrollTopToday)
                    }
                    else if selectedIndex == 1 {
                        IpoTotView(scrollTopTot: $scrollTopTot)
                    }
                    else if selectedIndex == 2 {
                        Spacer()
                    }
                    else if selectedIndex == 3 {
                        SettingView(viewRouter: viewRouter)
                    }
                    
                }
                
            }
            .overlay( // Overlay the custom TabView component here
                Color(hex: 0x000000) // Base color for Tab Bar
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(height: 50) // Match Height of native bar
                    .overlay(HStack {
                        
                        // Home Tab Button
                        Button(action: {
                            
                            let newValue = 0
                            
                            if newValue == selectedIndex {
                                scrollTopToday.toggle()
                            }
                            
                            self.selectedIndex = newValue
                            
                        }, label: {
                            VStack (alignment: .center) {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, alignment: .center)
                                    .foregroundColor(selectedIndex == 0 ? Color(hex: 0xCC0000) : Color(hex: 0x555555))
                            }
                            .frame(maxWidth: .infinity)
                        })
                        
                        
                        // First Tab Button
                        Button(action: {
                            
                            let newValue = 1
                            
                            if newValue == selectedIndex {
                                scrollTopTot.toggle()
                            }
                            
                            self.selectedIndex = newValue
                            
                        }, label: {
                            VStack (alignment: .center) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, alignment: .center)
                                    .foregroundColor(selectedIndex == 1 ? Color(hex: 0xCC0000) : Color(hex: 0x555555))
                            }
                            .frame(maxWidth: .infinity)
                        })
                        
                        
                        // Third Tab Button
                        Button(action: {
                            
                            let newValue = 2
                            
                            self.selectedIndex = newValue
                            
                        }, label: {
                            VStack (alignment: .center) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, alignment: .center)
                                    .foregroundColor(selectedIndex == 2 ? Color(hex: 0xCC0000) : Color(hex: 0x555555))
                            }
                            .frame(maxWidth: .infinity)
                        })
                        
                        // Fourth Tab Button
                        Button(action: {
                            
                            let newValue = 3
                            
                            self.selectedIndex = newValue
                            
                        }, label: {
                            VStack (alignment: .center) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, alignment: .center)
                                    .foregroundColor(selectedIndex == 3 ? Color(hex: 0xCC0000) : Color(hex: 0x555555))
                            }
                            .frame(maxWidth: .infinity)
                        })
                        
                    }), alignment: .bottom) // Align the overlay to bottom to ensure tab bar stays pinned.
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct MainIPOView_Previews: PreviewProvider {
    static var previews: some View {
        MainIPOView(viewRouter: ViewRouter())
            .preferredColorScheme(.dark)
    }
}
