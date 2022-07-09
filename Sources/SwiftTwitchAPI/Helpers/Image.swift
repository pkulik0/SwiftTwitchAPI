//
//  Image.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

struct Image: Codable {
    let url1X, url2X, url4X: String

    enum CodingKeys: String, CodingKey {
        case url1X = "url_1x"
        case url2X = "url_2x"
        case url4X = "url_4x"
    }
}
