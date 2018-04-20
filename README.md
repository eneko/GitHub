![Release](https://img.shields.io/github/release/eneko/github.svg)
![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg)
[![Build Status](https://travis-ci.org/eneko/GitHub.svg?branch=master)](https://travis-ci.org/eneko/GitHub)
[![Swift Package Manager Compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)
![Linux Compatible](https://img.shields.io/badge/linux-compatible%20🐧-brightgreen.svg)

# GitHub GraphQL API V4 client

This is a client for the [GitHub GraphQL API V4](https://developer.github.com/v4/).

Note: This client is in very early stages and currently has extremely limited functionality:
- Retrieve version tag for lastest release from a given repository.
- Retrieve list of open pull requests from a given repository.

## Usage

Initialize a client passing in a valid GitHub access token:
```swift
let token = "your_token"
let github = GitHub(token: token)
```

Retrieve latest release version of a given project:
```swift
let version = try github.latestRelease(owner: "eneko", project: "SourceDocs")
print(version)  // 0.5.0
```

Retrieve list of open pull requests on a given project:
```swift
let pullRequests = try github.openPullRequests(owner: "eneko", project: "SourceDocs")
print(pullRequests.count) // 0
```
