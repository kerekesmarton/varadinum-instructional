import CoreData
import Apollo

protocol Model {
    associatedtype T
    func generateEntity() -> T?
}

class Network {
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://eu1.prisma.sh/kerekes-marton-d1867d/instructional-cloud/dev")!)
}
