import CoreData
import Apollo

protocol Model {
    associatedtype T
    func generateEntity() -> T?
}

class Network {
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://eu1.prisma.sh/kerekes-marton-d1867d/instructional-cloud/dev")!)
    
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
