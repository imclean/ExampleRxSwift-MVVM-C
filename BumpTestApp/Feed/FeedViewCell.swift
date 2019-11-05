//
//  FeedViewCell.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class FeedViewCell: UITableViewCell {
    
    @IBOutlet weak var webView: WKWebView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var gif : Gif! {
        didSet {
            guard let imageURL = URL(string: gif.image.downsizedMedium.url) else {
                return
            }
            let cache =  URLCache.shared
            let request = URLRequest(url: imageURL)
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = cache.cachedResponse(for: request)?.data {
                    DispatchQueue.main.async { [weak self] in
                        self?.webView.scrollView.isScrollEnabled = false
                        self?.webView!.load(data, mimeType: "image/gif", characterEncodingName: String(), baseURL:URL(string: (self?.gif.image.downsizedMedium.url)!)!)
                    }
                } else {
                    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 {
                            let cachedData = CachedURLResponse(response: response, data: data)
                            cache.storeCachedResponse(cachedData, for: request)
                            DispatchQueue.main.async { [weak self] in
                                self?.webView.scrollView.isScrollEnabled = false
                                self?.webView!.load(data, mimeType: "image/gif", characterEncodingName: String(), baseURL:URL(string: (self?.gif.image.downsizedMedium.url)!)!)
                            }
                        }
                    }).resume()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        webView.load(URLRequest(url: URL(string:"about:blank")!))
    }
    
}
