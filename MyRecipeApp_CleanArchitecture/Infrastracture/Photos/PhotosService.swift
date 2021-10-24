//
//  PhotosService.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import Alamofire
import AlamofireImage

protocol PhotosService {
    func fetchImage(for url: String,
                    completion: @escaping (Image) -> Void,
                    errorCompletion: @escaping (Error) -> Void)
    
    func cacheImage(image: Image, for url: String)
    func getCachedImage(for url: String) -> Image
    func clearCachedImage(for url: String)
}

class PhotosProvider: PhotosService {
    
    func fetchImage(for url: String,
                    completion: @escaping (Image) -> Void,
                    errorCompletion: @escaping (Error) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    
    func cacheImage(image: Image, for url: String) {
        
    }
    
    func getCachedImage(for url: String) -> Image {
        return Image()
    }
    
    func clearCachedImage(for url: String) {
        
    }
    
}
