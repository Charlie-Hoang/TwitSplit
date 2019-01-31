//
//  TwitResult.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/28/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitResultProtocol
protocol TwitResultProtocol {
    
    associatedtype T
    var result: T? {get}
    var error: ZError? {get}
}

// MARK: ZError
// reprent all kind of error when validate message
public enum ZError: Error{
    
    case wordTooLong
    case empty
    case invalid
    
    public func toString() -> String?{
        switch self {
        case .wordTooLong:
            return "Message contain word(s) which are too long"
        case .empty:
            return "Message is empty"
        case .invalid:
            return "Message is invalid"
        }
    }
}

// MARK: TwitResult
// represent as result of split function
public enum TwitResult: TwitResultProtocol {
    
    public typealias T = [TwitSentence]
    case success(T)
    case failed(ZError)
    
    public var isSuccess: Bool{
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var result: T?{
        switch self {
        case .success(let result):
            return result
        default:
            return nil
        }
    }
    
    public var error: ZError?{
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }
    
    public func toStringArray() -> [String]{
        switch self {
        case .failed(let error):
            return [error.toString()!]
        case .success(let result):
            return result.map{$0.toString()}
        }
    }
}
