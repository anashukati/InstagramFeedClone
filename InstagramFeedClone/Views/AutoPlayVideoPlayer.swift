import SwiftUI
import AVKit

struct AutoPlayVideoPlayer: View {
    let videoURL: URL
    let index: Int
    @Binding var selectedIndex: Int
    @Environment(\.scenePhase) private var scenePhase

    @State private var player: AVPlayer
    @State private var isMostlyVisible: Bool = false

    init(videoURL: URL, index: Int, selectedIndex: Binding<Int>) {
        self.videoURL = videoURL
        self.index = index
        self._selectedIndex = selectedIndex
        _player = State(initialValue: AVPlayer(url: videoURL))
    }

    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(player: player)
                .onAppear {
                    addPlaybackObserver()
                    updatePlayback(with: geometry.frame(in: .global))
                }
                .onDisappear {
                    removePlaybackObserver()
                }
                .onChange(of: geometry.frame(in: .global)) { _ , newFrame in
                    updatePlayback(with: newFrame)
                }
                .onChange(of: selectedIndex) { _ , _ in
                    updatePlayback(with: geometry.frame(in: .global))
                }
                .onChange(of: scenePhase) { _ , newPhase in
                    if newPhase != .active {
                        player.pause()
                    }
                }
        }
        .frame(maxWidth: 400, maxHeight: 400)
    }

    private func updatePlayback(with frame: CGRect) {
        let screenHeight = UIScreen.main.bounds.height
        let visibleHeight = min(frame.maxY, screenHeight) - max(frame.minY, 0)
        let totalHeight = frame.height
        
        let visibilityRatio = visibleHeight / totalHeight
        isMostlyVisible = visibilityRatio > 0.95
        
        if isMostlyVisible && selectedIndex == index {
            player.play()
        } else {
            player.pause()
        }
    }

    private func addPlaybackObserver() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }

    private func removePlaybackObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }
}

