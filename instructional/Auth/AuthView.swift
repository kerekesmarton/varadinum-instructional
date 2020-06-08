import UIKit
import SwiftUI
import Lock
import Auth0

struct AuthHostView: View {
    var viewControllers: UIHostingController<AuthView>

    init(_ view: AuthView) {
        self.viewControllers = UIHostingController(rootView: view)
    }

    var body: some View {
        AuthView()
    }
}

struct AuthView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> AuthViewController {
        return AuthViewController()
    }

    func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {}
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    class Coordinator: NSObject {
//        var parent: AuthView
//
//        init(_ parent: AuthView) {
//            self.parent = parent
//        }
//    }
}

class AuthViewController: UIViewController {
    
    @Inject var credentialsManager: CredentialsManager
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if credentialsManager.hasValid() {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }
        presentAuth()
    }
    
    private func presentAuth() {
        
        Lock
        .classic()
        .withConnections{ connections in
            connections.database(name: "Username-Password-Authentication", requiresUsername: false)
        }
        .withStyle {
            $0.title = "Varadinum"
//            $0.logo = LazyImage(named: "company_logo")
//            $0.primaryColor = UIColor(red: 0.6784, green: 0.5412, blue: 0.7333, alpha: 1.0)
        }
        .withOptions {
            $0.closable = true
            $0.oidcConformant = true
            $0.scope = "openid profile"
        }
        .onAuth { credentials in
            self.save(credentials)
        }.onError(callback: { (error) in
            print(error)
        })
        .present(from: self)
    }
    
    private func save(_ credentials: Credentials) {
        guard let accessToken = credentials.accessToken else { return }
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch result {
                case .success( _ /*let profile*/):
                    _ = self.credentialsManager.store(credentials: credentials)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
