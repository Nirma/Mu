//
//  HTTPRequest.swift
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

public protocol HTTPRequest {
    
    var scheme: Scheme { get }
    var host: String { get }
    var path: String { get }
    var port: Int? { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var body: HTTPBody? { get }
    
    func composeRequest() -> URLRequest?
}

public extension HTTPRequest {
    
    func convert(queryParameters: [String: String]) -> [URLQueryItem] {
        return queryParameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    }
    
    func urlFromComponents() -> URL? {
        var components = URLComponents()
        components.scheme = scheme.description
        components.host = host
        components.path = path
        components.port = port
        
        if let query = queryParameters {
            components.queryItems = convert(queryParameters: query)
        }
        return components.url
    }

    func composeRequest() -> URLRequest? {
        guard let url = urlFromComponents() else { return nil }
    
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        headers.map {
            for (headerField, value) in $0 {
                request.addValue(value, forHTTPHeaderField: headerField)
            }
        }
        request.httpBody = body?.data
        return request
    }
}
