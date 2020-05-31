import SwiftUI


extension View {
    var anyView: AnyView {
        return AnyView(self)
    }
}

extension View {
    func makeErrorView(_ error: (ServiceError)) -> AnyView {
        return VStack {
            Text(error.localizedDescription)
        }.anyView
    }
    
    func makeLoadingView() -> AnyView {
        return VStack {
            Text("Loading")
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }.anyView
    }
}
