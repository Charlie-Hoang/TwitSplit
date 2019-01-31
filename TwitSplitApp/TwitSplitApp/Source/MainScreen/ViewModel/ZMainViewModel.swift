//
//  ZMainViewModel.swift
//  TwitSplitApp
//
//  Created by Charlie on 1/30/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import TwitSplitCore

// MARK: ZMainViewModelInputProtocol
protocol ZMainViewModelInputProtocol {
    
    var sendMessage: PublishSubject<ZMessage>{get}
}

// MARK: ZMainViewModelOutputProtocol
protocol ZMainViewModelOutputProtocol {
    
    var splittedTwit: PublishSubject<TwitResult>{get}
}

// MARK: ZMainViewModelProtocol
protocol ZMainViewModelProtocol {
    
    var input: ZMainViewModelInputProtocol{get}
    var output: ZMainViewModelOutputProtocol{get}
}

// MARK: ZMainViewModel
class ZMainViewModel: ZMainViewModelProtocol, ZMainViewModelInputProtocol, ZMainViewModelOutputProtocol {
    
    var input: ZMainViewModelInputProtocol {return self}
    var output: ZMainViewModelOutputProtocol {return self}
    
    private var disposeBag = DisposeBag()
    var sendMessage = PublishSubject<ZMessage>()
    var splittedTwit = PublishSubject<TwitResult>()
    
    init(){
        input.sendMessage.subscribe(onNext: {
            let service = TwitSplit()
            let result = service.splitMessage(message: $0.text)
            self.output.splittedTwit.onNext(result)
        }).disposed(by: disposeBag)
    }
}
