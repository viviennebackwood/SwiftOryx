//
//  NetworkError.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 25.08.2023.
//

import Foundation

// MARK: - Network Errors
enum NetworkError: Error {
    case wrappedError(Error)
    case invalidURL
    case requestFailed(reason: String)
    case decodingFailed(reason: String)
    case serverError(statusCode: Int)
    case noData
    case serializationFailed
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let reason):
            return "Request failed: \(reason)"
        case .decodingFailed(let reason):
            return "Decoding failed: \(reason)"
        case .serverError(_):
            let statusInfo = self.statusCodeIsSuccessful()
            return statusInfo.description
        case .noData:
            return "No data received."
        case .serializationFailed:
            return "Serialization failed."
        case .wrappedError(let error):
            return error.localizedDescription
        }
    }
    
     func statusCodeIsSuccessful() -> (success: Bool, description: String) {
            switch self {
            case .serverError(let statusCode):
                if 200..<300 ~= statusCode {
                    return (true, "Success: HTTP status code \(statusCode)")
                } else if 400..<500 ~= statusCode {
                    return (false, "Client error: HTTP status code \(statusCode)")
                } else if 500..<600 ~= statusCode {
                    return (false, "Server error: HTTP status code \(statusCode)")
                } else {
                    return (false, "HTTP status code \(statusCode)")
                }
            default:
                return (false, "No status code available.")
            }
        }
}
