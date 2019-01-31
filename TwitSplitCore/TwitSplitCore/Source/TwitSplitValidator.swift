//
//  TwitSplitValidator.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/29/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitSplitValidatable protocol
protocol TwitSplitValidatable {
    
    var configuration: TwitSplitConfigurable {get}
    func validateMessage(message: String?) -> ZError?
}

// MARK: TwitSplitValidator
// Responsiblity of message validation before splitting
struct TwitSplitValidator: TwitSplitValidatable {
    
    let configuration: TwitSplitConfigurable
    init(config: TwitSplitConfigurable){
        self.configuration = config
    }
    func validateMessage(message: String?) -> ZError?{
        guard let message = message else{
            return .invalid
        }
        guard !message.isEmpty else {
            return .empty
        }
        let words: [String] = message.components(separatedBy: .whitespaces)
        
        let invalidWords = words.filter{$0.count>configuration.maxTwitCharacters}
        guard invalidWords.isEmpty else{
            return .wordTooLong
        }
        return  nil
    }
}
