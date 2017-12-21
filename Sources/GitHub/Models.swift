//
//  Models.swift
//  GitHub
//
//  Created by Eneko Alonso on 12/19/17.
//

import Foundation

public struct Request: Codable {
    let query: String
}

public struct Response: Codable {
    let data: QueryResult
}

public struct QueryResult: Codable {
    let repository: Repository?
}

public struct Repository: Codable {
    let pullRequests: PullRequestConnection?
    let releases: ReleaseConnection?
}

public struct ReleaseConnection: Codable {
    let nodes: [Release]?
}

public struct Release: Codable {
    let name: String?
    let tag: Reference?
}

public struct PullRequestConnection: Codable {
    let nodes: [PullRequest]?
}

public struct PullRequest: Codable {
    let body: String?
    let closed: Bool?
    let merged: Bool?
    let number: Int?
    let title: String?
}

public struct Reference: Codable {
    let id: String
    let name: String
}
