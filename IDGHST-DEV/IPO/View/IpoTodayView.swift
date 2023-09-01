
import SwiftUI

struct IpoTodayView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var scrollTopToday: Bool
    
    @State private var ActiveIpoTodayToIpoDetail: Bool = false
    
    
    
    @State var 구분: String = ""
    @State var 종목코드: String = ""
    @State var 종목명: String = ""
    
    @State private var ipoData: IpoTodayData?
    
    @State private var isRefreshing = false
    
    @State private var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2)
            .repeatForever(autoreverses: false)
    }
    
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                ScrollViewReader { scrollProxy in
                    List {
                        Section {
                            
                            EmptyView().id(0)
                            
                            ForEach(ipoData?.공모주 ?? [], id: \.종목코드) { item in
                                
                                ZStack {
                                    
                                    EmptyView()
                                        .opacity(0)
                                        .buttonStyle(PlainButtonStyle())
                                    
                                    Button {
                                        ActiveIpoTodayToIpoDetail = true
                                        구분 = item.구분
                                        종목코드 = item.종목코드
                                        종목명 = item.종목명
                                    } label: {
                                        VStack(alignment: .leading, spacing: 20) {
                                            
                                            VStack(alignment: .leading) {
                                                Text("\(item.종목명)")
                                            }
                                            .font(.system(size: 24, weight: .bold))
                                            .lineLimit(1)
                                            
                                            Text("\(item.확정공모가)원")
                                                .font(.system(size: 16))
                                            
                                            HStack {
                                                Text("\(item.시장구분)")
                                                Text("\(item.구분)")
                                                    .font(.system(size: 16, weight: .bold))
                                                Spacer()
                                                Text("\(item.주간사.components(separatedBy: ", ")[0])")
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(28)
                                        .foregroundStyle(Color(hex: IpoColorsetFore[item.구분.components(separatedBy: ", ")[0]] ?? 0xFFFFFF))
                                        .background(Color(hex: IpoColorsetBack[item.구분.components(separatedBy: ", ")[0]] ?? 0xFFFFFF))
                                        .cornerRadius(20)
                                    }
                                    .sheet(isPresented: $ActiveIpoTodayToIpoDetail) {
                                        IpoDetailView(
                                            구분: $구분,
                                            종목코드: $종목코드,
                                            종목명: $종목명
                                        )
                                    }
                                    
                                }
                                
                            }
                        }
                        .background(Color.clear)
                        .listRowInsets(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
                    .onChange(of: scrollTopToday) { newValue in
                        print(newValue)
                        withAnimation {
                            scrollProxy.scrollTo(0, anchor: .top)
                        }
                    }
                }
            }
            
            if ipoData?.공모주.count == 0 {
                ZStack {
                    Text("오늘의 공모주\n정보가 없습니다.")
                        .font(.system(size: 30, weight: .black))
                        .multilineTextAlignment(.center)
                }
            }
            
            if isRefreshing {
                ZStack {
                    VStack {}
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(hex: 0x000000, opacity: 0.5))
                    
                    Image("loadingImage")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .rotationEffect(
                            Angle(
                                degrees:  self.isAnimating ? 360 : 0
                            )
                        )
                        .animation(self.isAnimating ? foreverAnimation : .default, value: isAnimating)
                        .onAppear{
                            self.isAnimating = true
                        }
                }
            }
            
        }
        .onAppear {
            fetchData()
            UITabBar.appearance().backgroundColor = .black
        }
        .refreshable {
            fetchData()
        }
    }
    
    func fetchData() {
        isRefreshing = true
        guard let url = URL(string: "http://idghstrpa.dothome.co.kr/api/공모주_오늘.php") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(IpoTodayData.self, from: data) {
                    DispatchQueue.main.async {
                        self.ipoData = decodedData
                        
                        // 로딩 화면 제거
                        self.isAnimating = false
                        isRefreshing = false
                    }
                }
            }
        }.resume()
    }
}

struct IpoTodayView_Previews: PreviewProvider {
    static var previews: some View {
        IpoTodayView(scrollTopToday: .constant(false))
            .preferredColorScheme(.dark)
    }
}
