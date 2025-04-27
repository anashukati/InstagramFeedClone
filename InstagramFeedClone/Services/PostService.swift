//
//  PostService.swift
//  InstagramFeedClone
//
//  Created by Ahmad on 27/04/2025.
//

protocol PostServiceProtocol {
    func fetchPosts() async -> [Post]
}

import Foundation

final class PostService: PostServiceProtocol {
    func fetchPosts() async -> [Post] {
        [
            Post(mediaItems: [
                MediaItem(type: .photo, url: "https://picsum.photos/id/1/5000/3333"),
                MediaItem(type: .photo, url: "https://fastly.picsum.photos/id/14/2500/1667.jpg?hmac=ssQyTcZRRumHXVbQAVlXTx-MGBxm6NHWD3SryQ48G-o")
            ]),
            Post(mediaItems: [
                MediaItem(type: .video, url: "https://i.imgur.com/J3vZD48.mp4")
            ]),
            Post(mediaItems: [
                MediaItem(type: .photo, url: "https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s"),
                MediaItem(type: .photo, url: "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA")
            ]),
            Post(mediaItems: [
                MediaItem(type: .photo, url: "https://fastly.picsum.photos/id/26/4209/2769.jpg?hmac=vcInmowFvPCyKGtV7Vfh7zWcA_Z0kStrPDW3ppP0iGI"),
                MediaItem(type: .video, url: "https://i.imgur.com/QBEDWQq.mp4"),
                MediaItem(type: .video, url: "https://i.imgur.com/hJuZnd3.mp4")
            ]),
            Post(mediaItems: [
                MediaItem(type: .video, url: "https://i.imgur.com/0Oxgcwh.mp4")
            ])
        ]
    }
}
