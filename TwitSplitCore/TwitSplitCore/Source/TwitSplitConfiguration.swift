//
//  TwitSplitConfiguration.swift
//  TwitSplitCore
//
//  Created by Charlie on 1/29/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

// MARK: TwitSplitConfigurable protocol
protocol TwitSplitConfigurable {
    var maxTwitCharacters: Int{get}
}

// MARK: TwitSplitConfiguration
struct TwitSplitConfiguration: TwitSplitConfigurable {
    public let maxTwitCharacters = 50
}
