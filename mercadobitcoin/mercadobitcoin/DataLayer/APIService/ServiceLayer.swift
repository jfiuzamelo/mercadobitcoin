import Foundation
import UIKit
import Network

extension ServiceLayer {
    // MARK: - HTTP Methods
    enum HTTPMethod: String {
        case POST
        case GET
        case PUT
        case PATCH
        case DELETE
    }
}

class ServiceLayer {
    
    /// Default TimeInterval (in seconds) used on network requests
    private let defaultTimeout: TimeInterval = 10
    
    /// Request to a given endpoint using URLSession handlering errors and succesfull data
    /// - Parameters:
    ///     - endpoint: A custom URLComponents structure that contains all the URL info.
    ///     - method: Define the HTTP Method of URLRequest.
    ///     - handler: Handler the dataTask completion based on an encode instance of U and a case of NetworkError
    func requestDataTask<U: Codable>(endpoint: Endpoint,
                                          method: HTTPMethod,
                                          shouldAddToken: Bool = true,
                                          timeout: TimeInterval = 10,
                                          then handler: @escaping (Result<U, NetworkError>) -> Void) {
        // Unwrap an URL from URLComponents
        guard let url = endpoint.url else {
            return handler(.failure(NetworkError.invalidURL))
        }
        
        // Create an URLRequest from a given URL
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("851769f4-0391-45e2-a9ce-2424c151e576", forHTTPHeaderField: "X-CoinAPI-Key")
        // Add default HTTPHeaders to the URLRequest
        var headers = request.allHTTPHeaderFields ?? [:]
        
        // Timeout
        request.timeoutInterval = defaultTimeout
        
        headers["Content-Type"] = "application/json"
        // Setup request
        request.allHTTPHeaderFields = headers
        // Set timeout to default
        request.timeoutInterval = timeout
        
        self.urlSessionDataTask(request, handler)
    }
}


extension ServiceLayer {
    private func urlSessionDataTask<U: Codable>(_ request: URLRequest,
                                                     _ handler: @escaping (Result<U, NetworkError>) -> Void) {
        
        let defaultSession = URLSession(configuration: .default)
        
        print("--------------------------------------ENDPOINT----------------------------------------")
        print(request.url ?? "")
        print("--------------------------------------------------------------------")
        
        let task = defaultSession.dataTask(with: request) { data, response, error in
            if let nsError = error as NSError? {
                print("dataTask error: \(nsError.code): \(nsError.description)")
                handler(.failure(NetworkError.generic(nsError)))
            }
            
            if data == nil {
                print("DATA is nil!")
            }
            
            if let urlResponse = response as? HTTPURLResponse {
                
                print("------------ JSON Response Body ------------")
                let stringData = String(data: data ?? Data(), encoding: .utf8)
                print(stringData ?? String())
                print("------------ HTTPURLResponse ------------")
                print(urlResponse)
                
                
                let result = data.map(Result.success) ?? .failure(NetworkError.generic(error))
                
                switch urlResponse.statusCode {
                case 200 ... 299:
                    do {
                        let responseObject = try JSONDecoder().decode(U.self, from: result.get())
                        
                        print("------------ Response Body decoded from JSON  ------------")
                        print(responseObject)
                        print("----------------------------------------------------------")
                        
                        
                        handler(.success(responseObject))
                    } catch {
                        print(error)
                        handler(.failure(NetworkError.decodeFailure))
                    }
                case 401:
                    // Unauthorized: ending session
                    DispatchQueue.main.async {
                        handler(.failure(NetworkError.unauthorized))
                    }
                    
                case 403:
                    do {
                        let responseObject = try JSONDecoder().decode(U.self, from: result.get())
                        print("------------ Response Body decoded from JSON  ------------")
                        print(responseObject)
                        print("----------------------------------------------------------")
                        
                        // Forbidden (forbidden access to an especific endPoint)
                        DispatchQueue.main.async {
                            handler(.failure(NetworkError.forbidden))
                        }
                    } catch {
                        handler(.failure(NetworkError.decodeFailure))
                    }
                default:
                    do {
                        let responseObject = try JSONDecoder().decode(U.self, from: result.get())
                        print("------------ Response Body decoded from JSON  ------------")
                        print(responseObject)
                        print("----------------------------------------------------------")
                        
                        
                        handler(.failure(NetworkError.error))
                        
                    } catch {
                        handler(.failure(NetworkError.decodeFailure))
                    }
                }
            }
        }
        task.resume()
    }
}
