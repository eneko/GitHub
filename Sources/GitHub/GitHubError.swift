//
//  GitHubError.swift
//  GitHubPackageDescription
//
//  Created by Eneko Alonso on 12/20/17.
//

import Foundation

public enum GitHubError: Error {
    case requestTimedOut
    case invalidResponse
    case repositoryNotFound(name: String)
}

extension GitHubError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .requestTimedOut:
            return "GitHub API request timed out."
        case .invalidResponse:
            return "Invalid response or no response received from GitHub API"
        case .repositoryNotFound(let name):
            return "Repository not found: \(name)"
        }
    }
}
