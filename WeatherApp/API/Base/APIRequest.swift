//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HttpEncoding {
    case ParameterEncoding
    case JSONEncoding
}

class Route {
    
    private(set) var urlPath: String = ""
    private(set) var method: HTTPMethod = .get
    private(set) var encoding: HttpEncoding = HttpEncoding.ParameterEncoding
    
    private init(path: String, method: HTTPMethod, encoding: HttpEncoding) {
        self.urlPath = path
        self.method = method
        self.encoding = encoding
    }
    
    static func getRoute(path: String) -> Route {
        return Route(path: path, method: .get, encoding: HttpEncoding.ParameterEncoding)
    }
    
    static func postRoute(path: String) -> Route {
        return Route(path: path, method: .post, encoding: HttpEncoding.JSONEncoding)
    }
    
}

class APIRequest<T: Decodable> {
    
    private var route: Route
    private var httpClient: HTTPClientSerivce!
    
    init(route: Route) {
        self.route = route
        httpClient = HTTPClient()
    }
    
    func getParameters() -> [String: Any] {
        return [:]
    }
    
    func getHeaders() -> [String: String] {
        return [:]
    }
    
    func changeAPIClient(client: HTTPClientSerivce) {
        self.httpClient = client
    }
    
    func cancel() {
        httpClient.cancel()
    }
    
    func response(completion: @escaping (Result<T, APIError>) -> Void) {
        do {
            let urlRequest = try asURLRequest()
            httpClient.dataTask(urlRequest: urlRequest) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let jsonObject = try JSONDecoder().decode(T.self, from: response)
                        DispatchQueue.main.async {
                            completion(Result.success(jsonObject))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(Result.failure(APIError.responseSerializationFailed(error)))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(Result.failure(error as! APIError))
            }
        }
    }
    
}

extension APIRequest {
    
    private var encodesParametersInURL: Bool {
        return route.encoding == .ParameterEncoding && route.method == .get
    }
    
    private func asURLRequest() throws -> URLRequest {
        let headers = getHeaders()
        let parameters = getParameters()
        
        var components = URLComponents(string: route.urlPath)
        if encodesParametersInURL {
            components?.queryItems?.append(contentsOf: queryItems(parameters: parameters))
        }
        
        guard let url = components?.url else {
            throw APIError.invalidRequestURL(URL(string: route.urlPath)!)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        
        if route.method == .post {
            switch route.encoding {
            case .ParameterEncoding:
                let components = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                request.httpBody = components.data(using: .utf8)
                
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }
                
                break
            case .JSONEncoding:
                do {
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    
                    if request.value(forHTTPHeaderField: "Content-Type") == nil {
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    }
                    
                    request.httpBody = data
                } catch {
                    throw APIError.ParameterEncodingError
                }
                break
            }
        }
        
        headers.forEach {
            request.setValue($0.key, forHTTPHeaderField: $0.value)
        }
        
        return request
    }
    
    private func queryItems(parameters: [String: Any]) -> [URLQueryItem] {
        let queryItems: [URLQueryItem] = parameters.compactMap { parameter -> URLQueryItem? in
            var result: URLQueryItem?
            if let intValue = parameter.value as? Int {
                result = URLQueryItem(name: parameter.key, value: String(intValue))
            } else if let stringValue = parameter.value as? String {
                result = URLQueryItem(name: parameter.key, value: stringValue)
            } else if let boolValue = parameter.value as? Bool {
                let value = boolValue ? "1" : "0"
                result = URLQueryItem(name: parameter.key, value: value)
            } else {
                return nil
            }
            return result
        }
        return queryItems
    }
    
    
}
