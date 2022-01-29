//
//  TVShowInfo.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import Foundation

struct EpisodeInfo {
   
    var seasonNumber: String?
    
    var episodeNumber: String?
    
    var episodeName: String?
    
    var episodeActors: String?

    var episodeDescription: String?

    var imagePath: String?

    static func getEpisodeInfoArray(episodes: [[String: Any]]?) -> [EpisodeInfo] {
        
        var episodeInfoArray = [EpisodeInfo]()
        
        guard let episodes = episodes else {
            return episodeInfoArray
        }
        
        for episode in episodes {
            
            var episodeInfo = EpisodeInfo()
            
            if let title = episode["Title"] as? String {
                episodeInfo.episodeName = title
            }
            
            if let season = episode["Season"] as? String {
                episodeInfo.seasonNumber = season
            }
            
            if let episodeNum = episode["Episode"] as? String {
                episodeInfo.episodeNumber = episodeNum
            }
            
            if let episodeActors = episode["Actors"] as? String {
                episodeInfo.episodeActors = episodeActors
            }
            
            if let episodeDescription = episode["Plot"] as? String {
                episodeInfo.episodeDescription = episodeDescription
            }
            
            if let poster = episode["Poster"] as? String {
                episodeInfo.imagePath = poster
            }

            episodeInfoArray.append(episodeInfo)
        }
        
        return episodeInfoArray
    }
}
