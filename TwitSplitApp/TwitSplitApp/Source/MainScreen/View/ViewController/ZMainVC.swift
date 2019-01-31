//
//  ZMainVC.swift
//  TwitSplitApp
//
//  Created by Charlie on 1/29/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TwitSplitCore

// MARK: ZMainVC
class ZMainVC: UIViewController {
    
    @IBOutlet weak var twitTableView: UITableView!
    @IBOutlet weak var twitTextView: ZTextView!
    @IBOutlet weak var twitInputView: UIView!
    @IBOutlet weak var twitInputViewBottomConstraint: NSLayoutConstraint!
    
    private var viewModel = ZMainViewModel()
    private let disposeBag = DisposeBag()
    private var tableDataSource = ZMainDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TwitSplit"
        
        setupInputView()
        setupTableView()
        binding()
    }
}

//MARK: setup Binding
extension ZMainVC{
    
    private func binding(){
        viewModel.output.splittedTwit.subscribe(onNext: {result in
            switch result{
                case .failed(let error):
                    self.handleError(error)
                case .success(let res):
                    self.tableDataSource.append(sentences: res)
                    self.twitTableView.reloadData()
            }
            
        }).disposed(by: disposeBag)
    }
    private func handleError(_ error: ZError){
        print(error)
        let alert = UIAlertController(title: "Failed", message: error.toString(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: setup TableView
extension ZMainVC{
    private func setupTableView(){
        self.twitTableView.register(UINib(nibName: ZTwitCell.identifier, bundle: nil), forCellReuseIdentifier: ZTwitCell.identifier)
        self.twitTableView.dataSource = self.tableDataSource
        self.twitTableView.delegate = self.tableDataSource
    }
}

//MARK: setup Input View
extension ZMainVC{
    private func setupInputView(){
        NotificationCenter.default.addObserver(self, selector: #selector(ZMainVC.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ZMainVC.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.twitTextView.layer.cornerRadius = 4
        self.twitTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.twitTextView.placeholderAttributedText = NSAttributedString(
            string: "Aa",
            attributes: [
                .font: self.twitTextView.textView.font!,
                .foregroundColor: UIColor.gray
            ]
        )
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction private func handleSendButton(_ sender: AnyObject) {
        viewModel.input.sendMessage.onNext(ZMessage(self.twitTextView.textView.text))
        self.twitTextView.textView.text = ""
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                //key point 0,
                self.twitInputViewBottomConstraint.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    @objc private func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.twitInputViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}
