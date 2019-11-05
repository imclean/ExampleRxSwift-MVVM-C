//
//  ViewController.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryBoarded {
    
    var coordinator: MainCoordinator?
    var viewModel: ViewControllerViewModel?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 220
        viewModel = ViewControllerViewModel()
        viewModel?.errors
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] (error) in
            switch error {
            case .internalError(let message):
                self?.showAlert(message: message)
            case .serverError(let message):
                self?.showAlert(message: message)
            }
        })
        .disposed(by: disposeBag)
        
        self.edgesForExtendedLayout = []
        self.title = NSLocalizedString("Gifs", comment: "Controller Title")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Internal Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil ))
        self.present(alert, animated: true)
    }
    
    private func setupBinding(){
        tableView.register(UINib(nibName: "FeedViewCell", bundle: Bundle.main), forCellReuseIdentifier: "feedCell")
        
        viewModel?.observableGifs.bind(to: tableView.rx.items(cellIdentifier: "feedCell", cellType: FeedViewCell.self)) { (_,gif,cell) in
                cell.gif = gif
            }.disposed(by: disposeBag)
    }
}
