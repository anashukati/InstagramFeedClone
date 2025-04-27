//
//  CacheManager.swift
//  InstagramFeedClone
//
//

import Foundation
import UIKit

class CacheManager {
    
    static let shared = CacheManager()

    
    private let imageCache = URLCache(memoryCapacity: 100_000_000, diskCapacity: 500_000_000, diskPath: "imageCache")
    private let fileManager = FileManager.default

    // MARK: - Image Caching

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if image is in cache
        if let cachedImage = getImageFromCache(url: url) {
            completion(cachedImage)
        } else {
            // Fetch image from URL if not cached
            fetchImage(from: url) { image in
                if let image = image {
                    self.saveImageToCache(image, url: url)
                }
                completion(image)
            }
        }
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
    private func getImageFromCache(url: URL) -> UIImage? {
        if let cachedResponse = imageCache.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }

    private func saveImageToCache(_ image: UIImage, url: URL) {
        guard let imageData = image.pngData() else { return }
        let response = URLResponse(url: url, mimeType: "image/png", expectedContentLength: imageData.count, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: imageData)
        imageCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
    
    // MARK: - Video Caching

       func loadVideo(from url: URL, completion: @escaping (URL?) -> Void) {
           // Check if video is in cache
           if let cachedVideoURL = getVideoFromCache(url: url) {
               completion(cachedVideoURL)
           } else {
               // Fetch video from URL if not cached
               fetchVideo(from: url) { videoURL in
                   if let videoURL = videoURL {
                       self.saveVideoToCache(videoURL, url: url)
                   }
                   completion(videoURL)
               }
           }
       }

       private func fetchVideo(from url: URL, completion: @escaping (URL?) -> Void) {
           let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent)
           let task = URLSession.shared.downloadTask(with: url) { location, _, _ in
               guard let location = location else {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
                   return
               }
               do {
                   try FileManager.default.moveItem(at: location, to: tempURL)
                   DispatchQueue.main.async {
                       completion(tempURL)
                   }
               } catch {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
               }
           }
           task.resume()
       }

       private func getVideoFromCache(url: URL) -> URL? {
           let cachedVideoURL = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent)
           if FileManager.default.fileExists(atPath: cachedVideoURL.path) {
               return cachedVideoURL
           }
           return nil
       }

       private func saveVideoToCache(_ videoURL: URL, url: URL) {
           let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent)
           do {
               try FileManager.default.copyItem(at: videoURL, to: destinationURL)
           } catch {
               print("Error saving video to cache: \(error)")
           }
       }
    
}

