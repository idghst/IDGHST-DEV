
import Foundation
import Combine
import SwiftUI

class ViewRouter : ObservableObject{
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()
    
    var currentPage: String = "MainView" {
        didSet{
            objectWillChange.send(self)
        }
    }
}
