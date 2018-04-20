**STRUCT**

# `GitHub`

```swift
public struct GitHub
```

## Methods
### `init(token:)`

```swift
public init(token: String)
```

### `submit(query:)`

```swift
public func submit(query: String) throws -> Response
```

### `latestRelease(owner:project:)`

```swift
public func latestRelease(owner: String, project: String) throws -> String?
```

### `openPullRequests(owner:project:limit:)`

```swift
public func openPullRequests(owner: String, project: String, limit: Int = 100) throws -> [PullRequest]
```
