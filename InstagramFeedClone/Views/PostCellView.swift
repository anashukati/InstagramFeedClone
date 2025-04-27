//
//  PostCellView.swift
//  InstagramFeedClone
//
//

import SwiftUI
import AVKit
import SwiftUI

struct PostCellView: View {
    let post: Post
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MediaCarouselView(
                viewModel: MediaCarouselViewModel(mediaItems: post.mediaItems),
                selectedIndex: $selectedIndex
            )

            if post.mediaItems.count > 1 {
                pageIndicator
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
    }

    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(post.mediaItems.indices, id: \.self) { index in
                Circle()
                    .fill(selectedIndex == index ? Color.primary : Color.secondary.opacity(0.5))
                    .frame(width: 8, height: 8)
            }
        }
    }
}
