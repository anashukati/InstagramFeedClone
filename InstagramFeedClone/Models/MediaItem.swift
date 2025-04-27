//
//  MediaItem.swift
//  InstagramFeedClone
//
//

import Foundation

enum MediaType {
    case photo
    case video
}

struct MediaItem: Identifiable {
    let id = UUID()
    let type: MediaType
    let url: String
}
