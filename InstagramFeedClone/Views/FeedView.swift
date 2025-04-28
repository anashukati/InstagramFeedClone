//
//  FeedView.swift
//  InstagramFeedClone
//
//
import SwiftUI


struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
            NavigationStack{
                ScrollView (showsIndicators: false){
                    LazyVStack{
                        ForEach(viewModel.posts) { post in
                            PostCellView(post: post)

                        }
                    }
                }.onAppear(){
                    Task {
                        await viewModel.loadPosts()
                    }
                }
                .navigationTitle("Instagram")

            }
        
        
    }
}

#Preview {
    FeedView()
}
