//
//  Client.swift
//  GitHub
//
//  Created by Eneko Alonso on 12/20/17.
//

import Foundation


struct Client {

    let token: String

    typealias CompletionBlock = (_ response: Response?, _ error: Error?) -> Void

    func submit(request: Request) throws -> Response {
        let urlRequest = try makeURLRequest(with: request)
        return try submit(urlRequest: urlRequest)
    }

    func makeURLRequest(with request: Request) throws -> URLRequest {
        guard let url = URL(string: "https://api.github.com/graphql") else {
            fatalError("Failed to make url")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        urlRequest.httpBody = try encoder.encode(request)

        return urlRequest
    }

    func submit(urlRequest: URLRequest) throws -> Response {
        var responseData: Response?
        let semaphore = DispatchSemaphore(value: 0)
        submit(urlRequest: urlRequest) { (response, error) in
            responseData = response
            semaphore.signal()
        }
        if semaphore.wait(timeout: DispatchTime.now() + 30) == .timedOut {
            throw GitHubError.requestTimedOut
        }
        guard let response = responseData else {
            throw GitHubError.invalidResponse
        }
        return response
    }

    func submit(urlRequest: URLRequest, completion: @escaping CompletionBlock) {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue())
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(Response.self, from: data) else {
                completion(nil, GitHubError.invalidResponse)
                return
            }
            completion(response, nil)
        }
        task.resume()
    }

}
