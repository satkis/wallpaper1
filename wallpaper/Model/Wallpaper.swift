//
//  Wallpaper.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation

class Wallpaper {
    private var _wallpaperName: String!
    private var _wallpaperId: Int!
    private var _wallpaperDetails: String!
    private var _wallpaperStatus: String!
    private var _wallpaperKey: String!
    private var _wallpaperUrl: String!
    private var _wallpaperVideoUrl: String!
    
    var wallpaperName: String {
        return _wallpaperName
    }
    
    var wallpaperUrl: String {
        return _wallpaperUrl
    }
    
    var wallpaperId: Int {
        return _wallpaperId
    }
    
    var wallpaperDetails: String {
        return _wallpaperDetails
    }
    
    var wallpaperStatus: String {
        return _wallpaperStatus
    }
    
    var wallpaperVideoUrl: String {
        return _wallpaperVideoUrl
    }
    
    init(wallpaperName: String, wallpaperId: Int, wallpaperDetails: String, wallpaperStatus: String, wallpaperUrl: String, wallpaperVideoUrl: String) {
        self._wallpaperName = wallpaperName
        self._wallpaperId = wallpaperId
        self._wallpaperDetails = wallpaperDetails
        self._wallpaperStatus = wallpaperStatus
        self._wallpaperUrl = wallpaperUrl
        self._wallpaperVideoUrl = wallpaperVideoUrl
    }
    
    init(wallpaperKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._wallpaperKey = wallpaperKey
        
        if let description = dictionary["description"] as? String {
            self._wallpaperDetails = description
        }
        
        
        if let url = dictionary["link"] as? String {
            self._wallpaperUrl = url
        }
        
        if let name = dictionary["name"] as? String {
            self._wallpaperName = name
        }
        
        if let status = dictionary["status"] as? String {
            self._wallpaperStatus = status
        }
        
        if let id = dictionary["id"] as? Int {
            self._wallpaperId = id
        }
        
        if let videoLink = dictionary["videoLink"] as? String {
            self._wallpaperVideoUrl = videoLink
        }
        
    }
}
