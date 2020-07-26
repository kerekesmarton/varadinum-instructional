import Foundation
import Apollo

enum ServiceError: Error {
    case empty
    case server(NSError)
    case decoding(DecodingError)
    case client(String)
    case auth(AuthError)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .client(let str):
            return "Something went wrong " + str
        case .decoding(let decodingError):
            return decodingError.localizedDescription
        case .server(let error):
            return error.localizedDescription
        case .auth(let authError):
            return authError.rawValue
        case .empty:
            return "Nothing here..."
        }
    }
    
    init(from error: Error) {
        if let error = error as? ServiceError {
            self = error
        } else if let error = error as? ApolloClient.ApolloClientError, let desc = error.errorDescription {
            self = .client(desc)
        } else if let error = error as? DecodingError {
            self = .decoding(error)
        } else if let authError = AuthError(from: error) {
            self = .auth(authError)
        } else {
            self = .server(error as NSError)
        }
    }
}
