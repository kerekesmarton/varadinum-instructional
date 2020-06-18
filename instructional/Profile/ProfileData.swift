import SwiftUI

enum ProfileViewModel {
    case result(Entities.User)
    case loading
    case error(ServiceError)
}

protocol ProfileObservable: ObservableObject {
    var viewModel: ProfileViewModel { get }
    
    func logout()
}
