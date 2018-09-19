//
//  DataService.swift
//  wallpaper
//
//  Created by satkis on 9/19/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation

class DataService {
    static let ds = DataService()
    
    private let categories = [
        Wallpaper(wallpaperName: "Name 0000", wallpaperId: "0.jpg", wallpaperDetails: "this is image number 0 0", wallpaperStatus: "Live"),
        Wallpaper(wallpaperName: "Name 11", wallpaperId: "1.jpg", wallpaperDetails: "this is image number 1111", wallpaperStatus: "Static"),
        Wallpaper(wallpaperName: "Name 222", wallpaperId: "2.jpg", wallpaperDetails: "this is image number 2222", wallpaperStatus: "Live"),
        Wallpaper(wallpaperName: "Name 333", wallpaperId: "3.jpg", wallpaperDetails: "this is image number 3333", wallpaperStatus: "Static"),
        Wallpaper(wallpaperName: "Name 444", wallpaperId: "4.jpg", wallpaperDetails: "this is image number 4444", wallpaperStatus: "Live")
        
    ]
    
    func getCategories() -> [Wallpaper]{
        return categories
    }
}
