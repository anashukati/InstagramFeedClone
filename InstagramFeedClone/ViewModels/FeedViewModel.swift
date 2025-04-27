//
//  FeedViewModel.swift
//  InstagramFeedClone
//
//

import Foundation

@MainActor
final class FeedViewModel: ObservableObject {
   
    @Published var posts: [Post] = []
    private let service: PostServiceProtocol
    
 
    init(service : PostServiceProtocol = PostService()) {
        self.service = service
    }
    
    
    func loadPosts() async {
        posts = await service.fetchPosts()
    }
}
