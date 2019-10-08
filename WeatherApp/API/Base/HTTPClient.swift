//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

public enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
}

protocol HTTPClientSerivce {
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, APIError>) -> Void))
    func cancel()
}

class HTTPClient: HTTPClientSerivce {
    
    typealias RequestResult = Result<Data, APIError>
    
    private var session: URLSession
    private var task: URLSessionTask?
    
    init(config: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: config)
    }
    
    func cancel() {
        task?.cancel()
    }
    
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, APIError>) -> Void)) {
        print("Request==>> \(String(describing: urlRequest.url))")
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(Result.failure(APIError.apiError(error)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(Result.failure(APIError.emptyData))
                return
            }
            guard response.statusCode == 200 else {
                completion(Result.failure(APIError.invalidStatusCode(response.statusCode)))
                return
            }
            completion(Result.success(data))
        }
        task?.resume()
    }
    
}
