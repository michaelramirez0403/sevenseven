//
//  BaseViewModel.swift
//  Deliveries
//
//  Created by Macky Ramirez on 5/19/20.
//  Copyright © 2020 Macky Ramirez. All rights reserved.
//
import Foundation
protocol BaseViewModelDelegate: AnyObject {
    func loading()
    func dismiss()
    func didRequestSuccess(_ msg: String)
    func didRequestFailed(_ error: String)
}
extension BaseViewModelDelegate {
    func loading() { }
    func dismiss() { }
    func didRequestSuccess(_ msg: String) { }
    func didRequestFailed(_ error: String) { }
}
class BaseViewModel: NSObject {
    weak var delegate: BaseViewModelDelegate?
    init(_ delegate: BaseViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
}
