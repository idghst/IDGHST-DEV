//
//  IpoDetailView.swift
//  IDGHST
//
//  Created by idghst on 8/26/23.
//

import SwiftUI
import Photos

struct IpoDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var 구분: String
    @Binding var 종목코드: String
    @Binding var 종목명: String
    
    @State private var ipoData: IpoDetailData?
    @State private var isRefreshing = false
    
    @State private var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2)
            .repeatForever(autoreverses: false)
    }
    
    
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        ForEach(ipoData?.공모주 ?? [], id: \.종목코드) { item in
                            
                            VStack (spacing: 0) {
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        
                                        VStack(alignment: .leading) {
                                            Text("\(item.종목명)")
                                        }
                                        .font(.system(size: 24, weight: .bold))
                                        
                                        Text("\(item.업종)")
                                    }
                                    Spacer()
                                    Image("testImage1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                                VStack (alignment: .leading, spacing: 20) {
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("공모가")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            Text("\(item.확정공모가)원")
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("주간사")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            ForEach(item.주간사.components(separatedBy: ", "), id: \.self) { item in
                                                Text(item)
                                            }
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("시장")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            Text("\(item.시장구분)")
                                        }
                                    }
                                    
                                }
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                                // MARK: 스케줄
                                VStack {}
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 10)
                                    .background(Color(hex: 0xFFFFFF, opacity: 0.15))
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        
                                        VStack(alignment: .leading) {
                                            Text("스케줄")
                                        }
                                        .font(.system(size: 24, weight: .bold))
                                    }
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                                VStack (alignment: .leading, spacing: 20) {
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("청약")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            Text("\(item.공모청약시작일) ~ \(item.공모청약종료일)")
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("환불")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            Text("\(item.환불일)")
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("상장")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 64)
                                        VStack (alignment: .leading) {
                                            Text("\(item.상장일)")
                                        }
                                    }
                                    
                                }
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                                // MARK: 경쟁률
                                VStack {}
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 10)
                                    .background(Color(hex: 0xFFFFFF, opacity: 0.15))
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        
                                        VStack(alignment: .leading) {
                                            Text("경쟁률")
                                        }
                                        .font(.system(size: 24, weight: .bold))
                                    }
                                    Spacer()
                                    Image(systemName: "percent")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                                VStack (alignment: .leading, spacing: 20) {
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("청약경쟁률")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 100)
                                        VStack (alignment: .leading) {
                                            Text("\(item.청약경쟁률)")
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("기관경쟁률")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 100)
                                        VStack (alignment: .leading) {
                                            Text("\(item.기관경쟁률)")
                                        }
                                    }
                                    HStack (alignment: .top) {
                                        HStack {
                                            Text("의무보유확약")
                                                .foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.8))
                                            Spacer()
                                        }
                                        .frame(width: 100)
                                        VStack (alignment: .leading) {
                                            Text("\(item.의무보유확약)")
                                        }
                                    }
                                    
                                }
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .foregroundStyle(Color.white)
                                
                            }
                            
                        }
                    }
                    .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    .padding(.top, 20)
                    .background(Color(hex: IpoColorsetBack[구분.components(separatedBy: ", ")[0]] ?? 0x000000, opacity: 0.75))
                }
                .listStyle(PlainListStyle())
            }
            .background(Color(hex: IpoColorsetBack[구분.components(separatedBy: ", ")[0]] ?? 0x000000, opacity: 0.75))
            
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
        }
    }
    
    func fetchData() {
        isRefreshing = true
        guard let url = URL(string: "http://idghstrpa.dothome.co.kr/api/공모주_상세.php?종목코드=" + 종목코드 + "&종목명=" + 종목명) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(IpoDetailData.self, from: data) {
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
    
    
    
    
    
    
    /// 이미지 저장
    func screenShot() {
        let screenshot = body.takeScreenshot(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
        UIImageWriteToSavedPhotosAlbum(screenshot, self, nil, nil)
        
        // 사진권한이 허용 되어 있으면 저장
        PHPhotoLibrary.requestAuthorization( { status in
            switch status {
            case .authorized:
                showingAlert = true
            case .denied:
                break
            case .restricted, .notDetermined:
                break
            default:
                break
            }
        })
    }
    
    /// 이미지 공유
    func share() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            
            let screenshot = mainWindow.takeScreenshot()
            let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
            
            if let rootViewController = mainWindow.rootViewController {
                rootViewController.present(activityViewController, animated: true)
            }
        }
        
    }
}

// UIView에 ScreenShot을 넣기 위함
private extension UIView {
    var screenShot: UIImage {
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return capturedImage
    }
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return screenshot
    }
}



// View에 ScreenShot을 넣기 위함
private extension View {
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.screenShot
    }
}












struct IpoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IpoDetailView(
            //            ActiveHome: .constant(true),
            //            ActiveDetail: .constant(true),
            구분: .constant("청약"),
            종목코드: .constant("454910"),
            종목명: .constant("두산로보틱스")
        )
        .preferredColorScheme(.dark)
    }
}
