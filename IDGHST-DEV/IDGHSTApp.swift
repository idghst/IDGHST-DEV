//
//  IDGHSTApp.swift
//  IDGHST
//
//  Created by idghst on 8/24/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct IDGHSTApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("deeplinkPath") var deeplinkPath: String = ""
    
    init() {
        // Kakao SDK 초기화
        let kakaoNativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewRouter: ViewRouter())
                .preferredColorScheme(.dark)
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        // AuthController.handleOpenUrl(url: url)
                        let handled = AuthController.handleOpenUrl(url: url)
                        if handled {
                            // Handle the URL successfully
                        } else {
                            // Handle the case where URL handling failed
                        }
                    }
                    /// 딥링크
                    if let host = url.host, host == "kakaolink" {
                        if let path = url.pathComponents.last {
                            deeplinkPath = path
                        }
                    }
                })
        }
    }
}

/// Color Hex
/// hex: 0x000000 형식으로 색상 16진수
/// opacity: 불투명도 (0.0 ~ 1.0)
extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: opacity
        )
    }
}

// 제스처 확장
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var inactiveTimer: Timer?
    var inactiveThreshold: TimeInterval = 10 // In seconds

    func applicationDidBecomeActive(_ application: UIApplication) {
        // App becomes active, stop the timer
        inactiveTimer?.invalidate()
        inactiveTimer = nil
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // App resigns active, start the timer
        inactiveTimer = Timer.scheduledTimer(withTimeInterval: inactiveThreshold, repeats: false) { [weak self] _ in
            // Handle the action you want to perform after the inactiveThreshold has passed
            print("App inactive for \(self?.inactiveThreshold ?? 0) seconds.")
        }
    }
    
    
    func scrollToTop() {
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            
            // Find UIScrollView and scroll to top
            if let rootViewController = keyWindow.rootViewController as? UIHostingController<TabView<Int, MainView>> {
                for case let scrollView as UIScrollView in rootViewController.view.subviews {
                    scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top), animated: true)
                }
            }
        }
    }
}
