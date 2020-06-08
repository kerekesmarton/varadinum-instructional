import Foundation
import Auth0

enum AppViewModel {
    case authRequired
    case start
}

protocol AppObservable: ObservableObject {
    var viewModel: AppViewModel { get }
}

class AppData: AppObservable {
    @Published var viewModel: AppViewModel = .start
    @Inject var credentialsManager: CredentialsManager
    
    init() {
        if credentialsManager.hasValid() {
            viewModel = .start
        } else {
            viewModel = .authRequired
        }
    }
}
