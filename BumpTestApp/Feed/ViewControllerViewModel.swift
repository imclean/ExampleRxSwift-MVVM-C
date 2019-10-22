//
//  ViewControllerViewModel.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import RxSwift

enum ModelErrors: Error {
    case serverError(String)
    case internalError(String)
}

class ViewControllerViewModel {
    
    var disposeBag = DisposeBag()
    var errors = PublishSubject<ModelErrors>()
    fileprivate let gifs = PublishSubject<[Gif]>()
    var observableGifs: Observable<[Gif]> {
        return gifs.asObservable()
    }
    
    init() {
        connectToApi(at: "https://api.giphy.com/v1/gifs/trending?api_key=YQD46PNuiExynupQ46HOzJqctivOHt16")
    }
    
    func connectToApi(at url:String) {
        collectGifs(url: url).subscribe(onNext: {[weak self] data in
            do {
                let gify = try JSONDecoder().decode(Giphy.self, from: data as! Data)
                self?.gifs.on(.next(gify.gifs))
            } catch {
                self?.errors.on(.next(.internalError("Internal Parsing Error")))
            }
        }, onError: { [weak self] error in
            self?.errors.on(.next(.internalError(error.localizedDescription)))
        }).disposed(by: disposeBag)
    }
    
    func collectGifs(url: String) -> Observable<Any> {
        return Observable.create { observer -> Disposable in
            let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] (data, response, error) in
                if let error = error {
                    self?.errors.on(.next(.serverError(error.localizedDescription)))
                    return
                }
                guard let data = data else {
                    self?.errors.on(.next(.serverError("Server Error")))
                    return
                }
                observer.onNext(data)
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
}
