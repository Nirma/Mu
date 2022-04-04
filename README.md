# Mu
![CI](https://github.com/nirma/mu/actions/workflows/CI.yml/badge.svg) 
![Swift 5.0](https://img.shields.io/badge/Swift-5.5+-orange.svg)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-blueviolet.svg)](https://github.com/apple/swift-package-manager)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

Minimalistic HTTP Requests library via async / await

# What is this?
Making HTTP API requests in Swift using `Foundation` can be verbose and use a mix of types like `URL`, `URLComponents` and `URLRequest` to form a request
and then handling all the encoding and decoding steps later.
While this code is not very complicated in can become extremely repetitive especially when writing requests by hand.

The goal of this Swift Package is to provide an extremely minimaistic lightweight abstraction layer between the user and the repetitive and verbose nature of Foundation to write HTTP requests. 

Mu allows the user to declare a request with it's body and headers up front along side its other details like endpoint to improve code readability and eliminate the boilerplate that comes with rolling HTTP requests send with `URLSession`.

# Installation
Going forward Swift Package Manager seems like it will replace Carthage and CocoaPods and since SPM is baked into Xcode why not?

To install Mu via SPM in Xcode go to `File` -> `Add Packages...` and enter `https://github.com/nirma/mu`


# Basic Usage
Mu is very simple as there are only two parts to it being a request that conforms to `HTTPRequest` and the `Requester`
that is used to send the request.

### `GET` Request

```swift
        let request = Request(
            scheme: .https,
            host: "api.github.com",
            path: "/users/nirma",
            method: .get,
            headers: ["Accept": "application/vnd.github.v3+json"]
        )
        
        let requester = Requester(decoder: JSONDecoder())

        Task {
            do {
                let (user, response) = try await requester.send(
                    request: request,
                    expect: ExpectedResponse.self // A `Decodable` type that is the expected response
                )
                ...
            } catch { ... }
        }
```

### `POST` Request

`POST` requests specify the body in terms of `HTTPBody`.
`HTTPBody` can either be raw `Data` or a type that conforms to Swift`s `Encodable`.

```swift
        let body = [
            "username": "foobar42",
            "email": "foobar42@github.com",
            "password_hash": "34973274ccef6ab4dfaaf86599792fa9c3fe4689"
        ]
        
        let request = Request(
            scheme: .https,
            host: "example.com",
            path: "/user/create",
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: HTTPBody(body)
        )
        
        let requester = Requester(decoder: JSONDecoder())

        Task {
            do {
                let (user, response) = try await requester.send(
                    request: request,
                    expect: ExpectedResponse.self // A `Decodable` type that is the expected response
                )
                ...
            } catch { ... }
        }
        
```

### Making requests with `HTTPRequest`
`HTTPRequest` is a protocol that all requests in this library must confrom to.
Included in this library is a simple class `Request` that implements this protocol and is purely included just for convenience
please feel free to implement your own types conforming to `HTTPRequest` or use or subclass `Request` if it suits your needs.

### Sending requests with `HTTPRequester`
Simply construct a type conforming to `HTTPRequester` and use the `send(request:expect)` method to send your request.
The response will be converted to the type specified by the `expect` parameter and an exception will be thrown if conversion fails.

`Requester` comes out of the box and accepts any type for decoding that conforms to `AbstractDecoder` default conformance has been 
applied to `JSONDecoder` so for requests expecting JSON responses simply pass in `JSONDecoder`:

```swift
let requester = Requester(decoder: JSONDecoder())
```
If `JSONDecoder` is not the right tool to get the job done then simply confrom the type you wish to use to `AbstractDecoder` and pass it in!

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
