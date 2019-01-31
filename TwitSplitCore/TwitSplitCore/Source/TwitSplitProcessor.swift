//
//  TwitSplitProcessor.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/29/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitSplitProcessable protocol
protocol TwitSplitProcessable {
    
    var configuration: TwitSplitConfigurable {get}
    var validator: TwitSplitValidatable {get}
    
    func process(message: String) ->  TwitResult
}

// MARK: TwitSplitProcessor
// response of process message to chunks of message
struct TwitSplitProcessor: TwitSplitProcessable{
    
    let configuration: TwitSplitConfigurable
    let validator: TwitSplitValidatable
    
    init(){
        self.configuration = TwitSplitConfiguration()
        self.validator = TwitSplitValidator(config: self.configuration)
    }
    // main function for process message
    // input: message as String
    // output: TwitResult
    func process(message: String) ->  TwitResult{
        if let error = validator.validateMessage(message: message){
            return .failed(error)
        }
        return split(message: message)
    }
    
}

//MARK: Private
extension TwitSplitProcessor{
    
    // main function for splitting valid message to chunks
    // input: message as String
    //        numberOfChunk: suppose is 1 at the first time function called
    // output: TwitResult
    private func split(message: String, numberOfChunk: Int = 1) ->  TwitResult{
        // trim message
        let message = message.trimmingCharacters(in: .whitespaces)
        
        // separate message to words
        var words = message.components(separatedBy: .whitespaces)
        
        // insert first word to first sentence
        var chunks: [TwitSentence] = [TwitSentence(config: configuration, text: words.remove(at: 0), index: 1, numberOfChunk: numberOfChunk)]
        
        // index of loop
        var wordsLoopIndex = 0
        
        // loop all word in words array or until create new sentence
        while chunks.count <= numberOfChunk && wordsLoopIndex<words.count {
            
            // last sentence
            let lastSentence = chunks.last!
            
            // traversal new word
            let word = words[wordsLoopIndex]
            
            // if sentence can not insert new word, add new senten
            if !lastSentence.add(word: word) {
                chunks.append(TwitSentence(config: configuration, text: word, index: chunks.count+1, numberOfChunk: numberOfChunk))
            }
            
            // increase loop index
            wordsLoopIndex += 1
        }
        
        // if chunk count greater numberOfChunk -> increase numberOfChunk and recusive split function
        if chunks.count > numberOfChunk{
            return split(message: message, numberOfChunk: chunks.count)
        }
        
        //return result
        return .success(chunks)
    }
}
