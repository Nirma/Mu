//
//  Request.swift
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/// This is a basic implementation of the `HTTPRequest` protocol.
/// If you have common properties that are the same across multiple requests
/// then subclassing `Request` and filling in those common values is one option
/// so `Request` is a class not a struct for that reason but using `struct`s is also encouraged
/// with `HTTPRequest`
open class Request: HTTPRequest {
    
    public var scheme: Scheme
    
    public var host: String
    
    public var path: String
    
    public var port: Int?
    
    public var headers: [String : String]?
    
    public var queryParameters: [String : String]?
    
    public var method: HTTPMethod
    
    public var body: HTTPBody?
    
    public init(
        scheme: Scheme,
        host: String,
        path: String,
        port: Int? = nil,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil,
        body: HTTPBody? = nil) {
            self.scheme = scheme
            self.host = host
            self.path = path
            self.port = port
            self.method = method
            self.body = body
            self.headers = headers
            self.queryParameters = queryParameters
        }
}
