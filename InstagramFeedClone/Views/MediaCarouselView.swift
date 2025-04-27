import SwiftUI

struct MediaCarouselView: View {
    @ObservedObject var viewModel: MediaCarouselViewModel
    @Binding var selectedIndex: Int

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(viewModel.mediaItems.indices, id: \.self) { index in
                mediaContent(for: index)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 400)
    }

    @ViewBuilder
    private func mediaContent(for index: Int) -> some View {
        let mediaItem = viewModel.mediaItems[index]

        switch mediaItem.type {
        case .photo:
            photoContent(for: index)
        case .video:
            videoContent(for: index)
        }
    }

    @ViewBuilder
    private func photoContent(for index: Int) -> some View {
        if let image = viewModel.images[index] {
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 400, maxHeight: 400)
        } else {
            ProgressView()
        }
    }

    @ViewBuilder
    private func videoContent(for index: Int) -> some View {
        if let videoURL = viewModel.videoURLs[index] {
            AutoPlayVideoPlayer(videoURL: videoURL, index: index, selectedIndex: $selectedIndex)
                .frame(maxWidth: 400, maxHeight: 400)
        } else {
            ProgressView()
        }
    }
}

