import SwiftUI
import Auth0

struct SignUpView: View {
    
    @ObservedObject var data = SignUpData()
    
    var userInfo: UserInfo    
    @State private var name: String = ""
    @State private var email: String = ""
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Finish setting up your new account").padding()
            
            Form {
                
                Section {
                    Text("Name")
                    TextField("John Appleseed", text: $name, onEditingChanged: { (isEditing) in
                        self.data.didChange(name: self.name, isEditing: isEditing)
                    }) {
                        self.data.didCommit(name: self.name)
                    }
                }
                
                Section {
                    Text("Email")
                    TextField("john.appleseed@email.com", text: $email, onEditingChanged: { (isEditing) in
                        self.data.didChange(email: self.email, isEditing: isEditing)
                    }) {
                        self.data.didCommit(email: self.email)
                    }
                }
            }
            
            UI.Button(vm: UI.Button.ViewModel(action: {
                self.data.done()
            }, text: "Done", image: nil, style: data.isValid ? .filled : .disabled, size: .large))
            
        .cornerRadius(5)
        }
        .navigationBarTitle("Your new account")
        .onAppear {
            self.name = self.userInfo.nickname ?? ""
            self.email = self.userInfo.name ?? ""
        }
        .keyboardAdaptive()
    }
}
