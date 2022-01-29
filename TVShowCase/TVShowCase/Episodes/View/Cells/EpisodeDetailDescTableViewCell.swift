//
//  EpisodeDetailDescTableViewCell.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import UIKit

class EpisodeDetailDescTableViewCell: UITableViewCell {

    @IBOutlet weak var labelActorsName: UILabel!
    @IBOutlet weak var labelEpisodeNumber: UILabel!
    @IBOutlet weak var labelEpisodeName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Internal Methods
    
    func populateEpisodeDetail(episodeInfo: EpisodeInfo?) {
        guard let episodeInfo = episodeInfo else {
            return
        }
        
        if let episodeName = episodeInfo.episodeName {
            self.labelEpisodeName.text = episodeName
        }
        if let episodeNumber = episodeInfo.episodeNumber {
            self.labelEpisodeNumber.text = "Episode Number: \(episodeNumber)"
        }
        
        if let episodeActors = episodeInfo.episodeActors {
            self.labelActorsName.text = "Actors: \(episodeActors)"
        }
        
        if let episodeDesc = episodeInfo.episodeDescription {
            self.labelDescription.text = "Summary: \(episodeDesc)"
        }
    }
}
