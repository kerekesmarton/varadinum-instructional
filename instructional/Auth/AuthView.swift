import UIKit
import SwiftUI
import Lock
import Auth0

struct AuthHostView: View {
    var viewControllers: UIHostingController<AuthView>
    var completion: AuthCompletion
    
    init(_ view: AuthView, completion: @escaping AuthCompletion) {
        self.viewControllers = UIHostingController(rootView: view)
        self.completion = completion
    }

    var body: some View {
        AuthView(completion: completion)
    }
}

typealias AuthCompletion = ()->Void

struct AuthView: UIViewControllerRepresentable {
    
    @Inject var sessionManager: SessionPublisher
    @Environment(\.presentationMode) var presentationMode
    var completion: AuthCompletion
    
    init(completion: @escaping AuthCompletion) {
        self.completion = completion
    }

    func makeUIViewController(context: Context) -> LockViewController {
        return Lock
        .classic()
        .withConnections{ connections in
            connections.database(name: "Username-Password-Authentication", requiresUsername: false)
        }
        .withStyle {
            $0.title = "Varadinum"
        }
        .withOptions {
            $0.closable = true
            $0.oidcConformant = true
            $0.scope = "openid profile"
        }.onAuth { credentials in
            self.save(credentials)
        }
        .onError(callback: { (error) in
            print(error)
        }).controller
    }

    func updateUIViewController(_ uiViewController: LockViewController, context: Context) {}
    
    private func save(_ credentials: Credentials) {
        guard let accessToken = credentials.accessToken else { return }
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch result {
                case .success( let userInfo):
                    self.sessionManager.save(credentials)
                    self.sessionManager.save(userInfo)
                    self.completion()
                case .failure(let error):
                    print(error)
                }
        }
    }
}
