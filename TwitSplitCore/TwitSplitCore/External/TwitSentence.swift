//
//  TwitSentence.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/28/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitSentenceProtocol
protocol TwitSentenceProtocol {
    
    func toString() -> String
}

// MARK: TwitSentence
// represent as every chunk after split message
public class TwitSentence: TwitSentenceProtocol{
    
    var configuration: TwitSplitConfigurable
    var text: String
    let index: Int
    let numberOfChunk: Int
    
    init(config: TwitSplitConfigurable, text: String, index: Int, numberOfChunk: Int) {
        self.configuration = config
        self.text = text
        self.index = index
        self.numberOfChunk = numberOfChunk
    }
    
    public func toString() -> String{
        if numberOfChunk == 1{
            return text
        }
        return "\(prefix)\(text)"
    }
}

// MARK: private
extension TwitSentence{
    
    var prefix: String{
        return "\(index)/\(numberOfChunk) "
    }
    
    var characterLimit: Int{
        return configuration.maxTwitCharacters - prefix.count
    }
    
    func add(word: String) -> Bool{
        let sentence = "\(text) \(word)"
        if sentence.count <= characterLimit{
            text = sentence
            return true
        }
        return false
    }
}
