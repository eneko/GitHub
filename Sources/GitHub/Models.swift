//
//  Models.swift
//  GitHub
//
//  Created by Eneko Alonso on 12/19/17.
//

import Foundation

struct Request: Codable {
    let query: String
}

struct Response: Codable {
    let data: Query
}

struct Query: Codable {
    let repository: Repository?
}

struct Repository: Codable {
    let pullRequests: PullRequestConnection?
    let releases: ReleaseConnection?
}

struct ReleaseConnection: Codable {
    let nodes: [Release]?
}

struct Release: Codable {
    let name: String?
    let tag: Reference?
}

struct PullRequestConnection: Codable {
    let nodes: [PullRequest]?
}

public struct PullRequest: Codable {
    let body: String?
    let closed: Bool?
    let merged: Bool?
    let number: Int?
    let title: String?
}

struct Reference: Codable {
    let id: String
    let name: String
}
