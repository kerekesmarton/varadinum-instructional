import SwiftUI

struct UserView<T: UserObservable>: View {
    
    @ObservedObject var data: T
    
    var body: some View {
        switch data.viewModel {
        case .loading:
            return makeLoadingView()
        case .login(let completion):
            return makeLoginView(completion: completion)
        case .error(let error):
            return makeErrorView(error)
        case .result(let user):
            return makeView(user)
        }
    }
    
    func makeView(_ user: Entities.User) -> AnyView {
        NavigationView {
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
            })
        }.anyView
    }
    
    func makeLoginView(completion: @escaping AuthCompletion) -> AnyView {
        return AuthView(completion: completion).anyView
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profile: Entities.User(id: UUID().uuidString, name: "John"))
//    }
//}
