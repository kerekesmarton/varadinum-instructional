import SwiftUI

struct ProfileView<T: ProfileObservable>: View {
    
    @ObservedObject var data: T
    
    var body: some View {
        switch data.viewModel {
        case .loading:
            return makeLoadingView()
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
                    ProfileTitleView(user: user)
                    
                    Button(action: {}) {
                        Text("Edit Profile").fontWeight(.bold)
                    }
                    .frame(width: 400)
                    .padding()

                    Divider()

                    Spacer()

                    WorkshopsListView(workshopData: WorkshopData(feature: .profile(user)))

                    Spacer()
                }
            }
            .navigationBarTitle(user.name)
            .navigationBarItems(trailing: Button("Log out") {
                self.data.logout()
            })
        }.anyView
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profile: Entities.User(id: UUID().uuidString, name: "John"))
//    }
//}
