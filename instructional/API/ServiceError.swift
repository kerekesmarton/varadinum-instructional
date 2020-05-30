import Foundation
import Apollo

enum ServiceError: Error {
    case empty
    case server(NSError)
    case decoding(DecodingError)
    case client(String)
    
    init(from error: Error) {
        if let error = error as? ApolloClient.ApolloClientError, let desc = error.errorDescription {
            self = .client(desc)
        } else if let error = error as? DecodingError {
            self = .decoding(error)
        } else {
            self = .server(error as NSError)
        }
    }
}
