//
//  DataService.swift
//  wallpaper
//
//  Created by satkis on 9/19/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation
import Firebase

let URL_GENERAL = Database.database().reference(fromURL: "https://wallpaper-6d603.firebaseio.com/")

class DataService {
    static let ds = DataService()
    
        private var _REF_BASE = URL_GENERAL
        private var _REF_WALLPAPERS = URL_GENERAL.child("wallpapers")
    
    
        // make publicly available
        var URL_BASE: DatabaseReference! {
            return _REF_BASE
        }
    
        var URL_WALLPAPERS: DatabaseReference! {
            return _REF_WALLPAPERS
        }
    
//    private let categories = [
//        Wallpaper(wallpaperName: "Name 0000", wallpaperId: "0.jpg", wallpaperDetails: "this is image number 0 0", wallpaperStatus: "Live"),
//        Wallpaper(wallpaperName: "Name 11", wallpaperId: "1.jpg", wallpaperDetails: "this is image number 1111", wallpaperStatus: "Static"),
//        Wallpaper(wallpaperName: "Name 222", wallpaperId: "2.jpg", wallpaperDetails: "this is image number 2222", wallpaperStatus: "Live"),
//        Wallpaper(wallpaperName: "Name 333", wallpaperId: "3.jpg", wallpaperDetails: "this is image number 3333", wallpaperStatus: "Static"),
//        Wallpaper(wallpaperName: "Name 444", wallpaperId: "4.jpg", wallpaperDetails: "this is image number 4444", wallpaperStatus: "Live"),
//        Wallpaper(wallpaperName: "Name 555", wallpaperId: "5.jpg", wallpaperDetails: "this is image number 5555", wallpaperStatus: "Live"),
//        //Wallpaper(wallpaperName: "Name 666", wallpaperId: "6.jpg", wallpaperDetails: "this is image number 6666", wallpaperStatus: "Live"),
//        Wallpaper(wallpaperName: "Name 666", wallpaperId: "6.HEIC", wallpaperDetails: "this is image number 6666", wallpaperStatus: "Live")
//        
//    ]
    
//    func getCategories() -> [Wallpaper]{
//        return categories
//    }
}
