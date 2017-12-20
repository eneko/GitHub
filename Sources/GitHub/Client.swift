//
//  Client.swift
//  GitHub
//
//  Created by Eneko Alonso on 12/20/17.
//

import Foundation

struct Client {

    let token: String

    func makeRequest(query: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.github.com/graphql") else {
            fatalError("Failed to make url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(Request(query: query))

        return request
    }

    func submitRequest(request: URLRequest) throws -> Response {
        var responseData: Data?
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue())
        let task = session.dataTask(with: request) { (data, response, error) in
            responseData = data
            semaphore.signal()
        }
        task.resume()

        if semaphore.wait(timeout: DispatchTime.now() + 30) == .timedOut {
            throw GitHubError.requestTimedOut
        }
        guard let data = responseData else {
            throw GitHubError.invalidResponse
        }

        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }

}
