import SwiftUI
import Auth0

struct UserView<T: UserObservable>: View {
    
    @ObservedObject var data: T
    
    var body: some View {
        NavigationView<AnyView> {
            switch data.viewModel {
            case .loading:
                return makeLoadingView()
            case .login(let session):
                return makeLoginView(session: session)
            case .error(let error):
                return makeErrorView(error)
                    .navigationBarItems(trailing: Button("Log out") {
                        self.data.logout()
                    })
                    .anyView
            case .result(let user):
                return makeView(user)
            case .signup(userInfo: let userInfo):
                return makeSignUpView(userInfo: userInfo)
            }
        }        
    }
    
    func makeView(_ user: Entities.User) -> AnyView {
        GeometryReader { geometry in
            VStack {
                UserTitleView(user: user)
                
                Button(action: {}) {
                    Text("Edit Profile").fontWeight(.bold)
                }
                .frame(width: 400)
                .padding()
                
                Divider()
                
                Spacer()
                
                WorkshopsListView(workshopData: WorkshopsListData(feature: .profile(user)))
                
                Spacer()
            }
        }
        .navigationBarTitle(user.name)
        .navigationBarItems(trailing: Button("Log out") {
            self.data.logout()
        }).anyView
    }
    
    func makeLoginView(session: SessionPublisher) -> AnyView {
        return AuthView(session: session).anyView
    }
    
    func makeSignUpView(userInfo: UserInfo) -> AnyView {
        return SignUpView(userInfo: userInfo).anyView
    }
}
