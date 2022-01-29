//
//  EpisodeImageDetailTableViewCell.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import UIKit
import Alamofire
import AlamofireImage

class EpisodeImageDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewEpisode: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Internal Methods
    
    func populateEpisodeImage(episodeInfo: EpisodeInfo?) {
        guard let episodeInfo = episodeInfo else {
            return
        }
        
        if let imagePath = episodeInfo.imagePath {
            
            AF.request(imagePath).responseImage { response in
                
                if case .success(let image) = response.result {
                    self.imageViewEpisode.image = image
                }
            }
        }
    }
}
