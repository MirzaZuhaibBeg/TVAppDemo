//
//  SeasonInfo.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import Foundation

struct SeasonInfo {
    
    var episodesInfoArray: [EpisodeInfo]?
    
    var seasonNumber: String?

    static func getSeasonInfoArray(seasons: [[String: Any]]?) -> [SeasonInfo] {
        
        var seasonInfoArray = [SeasonInfo]()
        
        guard let seasons = seasons else {
            return seasonInfoArray
        }
        
        for season in seasons {
            
            var seasonInfo = SeasonInfo()

            if let episodes = season["episodes"] as? [[String: Any]] {
                seasonInfo.episodesInfoArray = EpisodeInfo.getEpisodeInfoArray(episodes: episodes)
            }
            seasonInfo.seasonNumber = self.getSeasonNumber(episodes: seasonInfo.episodesInfoArray)
            
            seasonInfoArray.append(seasonInfo)
        }
        
        return seasonInfoArray
    }
    
    static func getSeasonNumber(episodes: [EpisodeInfo]?) -> String? {
        guard let episodes = episodes, let episode = episodes.first, let seasonNumber = episode.seasonNumber else {
            return nil
        }
 
        return seasonNumber
    }
}
