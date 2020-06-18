import Foundation
import Auth0
import SwiftUI

enum AppViewModel {
    case authRequired
    case start
}

protocol AppObservable: ObservableObject {
    var viewModel: AppViewModel { get }
}

class AppData: AppObservable {
    @Published var viewModel: AppViewModel = .start
    
    @ObservedObject var session = SessionPublisher() {
        didSet{
            guard session.credentials != nil else {
                self.viewModel = .authRequired
                return
            }
            self.viewModel = .start
        }
    }
}
