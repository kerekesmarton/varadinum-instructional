import SwiftUI

struct ProfileTitleView: View {
    
    var profile: Profile
    
    var body: some View {
        HStack{
            VStack{
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(radius: 3)
                    .lineLimit(1)
            }.padding()
            
            VStack{
                Text("9999")
                    .font(.title)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text("Publications")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }.padding(.leading)
            
            VStack{
                Text("9999")
                    .font(.title)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text("Followers")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }
            
            VStack{
                Text("9999")
                    .font(.title)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text("Following")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }
        }
        .frame(height: 100)
    }
}

struct ProfileTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTitleView(profile: Profile(id: "1", name: "John"))
    }
}
