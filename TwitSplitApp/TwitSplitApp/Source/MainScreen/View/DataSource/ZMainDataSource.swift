//
//  ZMainDataSource.swift
//  TwitSplitApp
//
//  Created by Charlie on 1/30/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import UIKit
import TwitSplitCore

// MARK: ZMainDataSource
class ZMainDataSource: NSObject{
    private var data: [TwitSentence] = []
    func append(sentence: TwitSentence){
        data.append(sentence)
    }
    func append(sentences: [TwitSentence]){
        data.append(contentsOf: sentences)
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate
extension ZMainDataSource: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZTwitCell.identifier, for: indexPath) as! ZTwitCell
        cell.config(sentence: data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
