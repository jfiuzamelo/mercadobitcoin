import Foundation

public enum NetworkError: Error {
    case error
    case invalidURL
    case encodeFailure
    case decodeFailure
    case cancelled
    case generic(Error? = nil)
    case unauthorized
    case internalServerError
    case forbidden
}
