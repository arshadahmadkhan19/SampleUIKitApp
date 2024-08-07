//
//  PostsModel.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Foundation

struct PostsModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title:  String?
    let body: String?
}
