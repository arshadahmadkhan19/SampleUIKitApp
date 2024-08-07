//
//  PhotoModel.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Foundation

struct PhotoModel: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
