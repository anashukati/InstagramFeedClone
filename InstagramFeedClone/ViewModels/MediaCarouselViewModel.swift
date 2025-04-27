//
//  MediaCarouselViewModel.swift
//  InstagramFeedClone
//
//

import Foundation
import SwiftUI

class MediaCarouselViewModel: ObservableObject {
    let mediaItems: [MediaItem]

    @Published var images: [Image?]
    @Published var videoURLs: [URL?]

    init(mediaItems: [MediaItem]) {
        self.mediaItems = mediaItems
        self.images = Array(repeating: nil, count: mediaItems.count)
        self.videoURLs = Array(repeating: nil, count: mediaItems.count)
        
        loadMedia()
    }

    private func loadMedia() {
        for (index, mediaItem) in mediaItems.enumerated() {
            if mediaItem.type == .photo, let url = URL(string: mediaItem.url) {
                CacheManager.shared.loadImage(from: url) { [weak self] loadedImage in
                    DispatchQueue.main.async {
                        self?.images[index] = loadedImage.map { Image(uiImage: $0) }
                    }
                }
            } else if mediaItem.type == .video, let url = URL(string: mediaItem.url) {
                CacheManager.shared.loadVideo(from: url) { [weak self] loadedVideoURL in
                    DispatchQueue.main.async {
                        self?.videoURLs[index] = loadedVideoURL
                    }
                }
            }
        }
    }
}
