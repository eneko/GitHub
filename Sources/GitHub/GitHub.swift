//
//  GitHub.swift
//  GitHub
//
//  Created by Eneko Alonso on 12/19/17.
//

import Foundation

public struct GitHub {
    let client: Client

    public init(token: String) {
        client = Client(token: token)
    }

    public func latestRelease(owner: String, project: String) throws -> String? {
        let query = """
            query {
              repository(owner: "\(owner)", name: "\(project)") {
                releases(last: 1) {
                  nodes {
                    name
                    tag {
                      id
                      name
                    }
                  }
                }
              }
            }
            """

        let response = try client.submitRequest(request: client.makeRequest(query: query))
        guard let repository = response.data.repository else {
            throw GitHubError.repositoryNotFound(name: project)
        }
        return repository.releases?.nodes?.first?.tag?.name
    }

    public func openPullRequests(owner: String, project: String, limit: Int = 100) throws -> [PullRequest] {
        let query = """
            query {
                repository(owner: "\(owner)", name: "\(project)") {
                    pullRequests(states: [OPEN], first: \(limit)) {
                        nodes {
                            createdAt
                            number
                            title
                        }
                    }
                }
            }
            """

        let response = try client.submitRequest(request: client.makeRequest(query: query))
        guard let repository = response.data.repository else {
            throw GitHubError.repositoryNotFound(name: project)
        }
        return repository.pullRequests?.nodes ?? []
    }

}
