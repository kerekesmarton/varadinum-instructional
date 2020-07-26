import CoreData
import Apollo
import Combine

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
     
    
    @Inject var session: SessionPublisher
    
    private lazy var networkTransport: HTTPNetworkTransport = {
        let transport = HTTPNetworkTransport(url: Environment.local.url)
        transport.delegate = self
        return transport
    }()
    
     private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
    
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
    
    func fetch<T: GraphQLQuery>(query: T) -> Future<GraphQLResult<T.Data>, ServiceError> {
        
        return Future { promise in
            
            self.fetch(query: query) { (result) in
                switch result {
                case .success(let graphResult):
                    promise(.success(graphResult))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    
    return true
  }
  
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
                        
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    if let token = session.getToken() {
        headers["Authorization"] = "Bearer \(token)"
    }
    
    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
  }
}
