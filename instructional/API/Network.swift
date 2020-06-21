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
    
    enum Environment: String, Codable {
        case dev = "https://ewn3plzne1.execute-api.eu-west-1.amazonaws.com/dev/graphql"
        case local = "http://localhost:4000/graphql"
        
        var url: URL {
            switch self {
            case .dev:
                return URL(string: rawValue)!
            case .local:
                return URL(string: rawValue)!
            }
        }
    }
    
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
