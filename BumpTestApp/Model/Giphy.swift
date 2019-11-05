//
//  Giphy.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import Foundation

// MARK: - Giphy
struct Giphy: Codable {
    let gifs: [Gif]
    
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}

// MARK: - Gif
struct Gif: Codable {
    let id: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id
        case image = "images"
    }
}

// MARK: - Image
struct Image: Codable {
    let downsizedMedium: GifFormat

    enum CodingKeys: String, CodingKey {
        case downsizedMedium = "fixed_height"
    }
}

// MARK: - GifFormat
struct GifFormat: Codable {
    let url: String
    let width, height: String
    let size: String?
}
