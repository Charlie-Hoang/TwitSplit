//
//  ZTwitCell.swift
//  TwitSplitApp
//
//  Created by Charlie on 1/30/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit
import TwitSplitCore

// MARK: CellIdentifiable
// get identifier of Cell
protocol CellIdentifiable {
    static var identifier: String{get}
}
extension CellIdentifiable{
    static var identifier: String{
        return String(describing: self)
    }
}

// MARK: CellConfigurable
protocol CellConfigurable {
    func config(sentence: TwitSentence)
}

// MARK: ZTwitCell
class ZTwitCell: UITableViewCell, CellConfigurable, CellIdentifiable {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(sentence: TwitSentence){
        self.messageLabel.text = sentence.toString()
        self.messageLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 40
    }
}
