//
//  TwitSplit.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/28/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitSplitable protocol
protocol TwitSplitable {
    // main function
    func splitMessage(message: String) -> TwitResult
}

// MARK: TwitSplit
// main service of TwitSplitCore
public class TwitSplit: TwitSplitable {
    
    let processor: TwitSplitProcessor
    
    public init(){
        processor = TwitSplitProcessor()
    }
    
    public func splitMessage(message: String) -> TwitResult{
        return processor.process(message: message)
    }
}
