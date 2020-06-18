import CoreData
import Apollo

struct Entities {}

protocol Model {
    associatedtype T
    func generateEntity() -> T?
}

protocol AssisttedModel {
    associatedtype T
    associatedtype Associate
    func generateEntity(with associate: Associate) -> T?
}

class Network {
    @Inject var apollo: ApolloClient
    
    func fetch<T: GraphQLQuery>(query: T, completion: @escaping (Result<GraphQLResult<T.Data>, ServiceError>) -> Void ) {
        
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphResult):
                completion(.success(graphResult))
            case .failure(let error):
                completion(.failure(ServiceError(from: error)))
            }
        }
    }
}

enum Environment: String, Codable {
    case dev = "https://eu1.prisma.sh/kerekes-marton-d1867d/instructional-cloud/dev"
    
    var url: URL {
        switch self {
        case .dev:
            return URL(string: self.rawValue)!
        }
    }
}
