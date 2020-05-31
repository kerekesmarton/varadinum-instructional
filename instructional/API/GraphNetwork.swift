import CoreData
import Apollo

struct Entities {}

protocol Model {
    associatedtype T
    func generateEntity() -> T?
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
