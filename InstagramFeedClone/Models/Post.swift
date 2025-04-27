//
//  Post.swift
//  InstagramFeedClone
//
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let mediaItems: [MediaItem]
}
