//
//  EpisodeDetailsViewController.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import UIKit

enum EpisodeViewType: Int {
    case EpisodeViewType_EpisodeImage = 0
    case EpisodeViewType_EpisodeDesc
}

class EpisodeDetailsViewController: UIViewController {
    
    var episodeInfo: EpisodeInfo?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
    }
    
    //MARK: Helper Methods
    
    private func customizeView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.episodeNavigationDetailTitle
        
        self.tableView.register(UINib(nibName: "EpisodeImageDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeImageDetailTableViewCell")
        self.tableView.register(UINib(nibName: "EpisodeDetailDescTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeDetailDescTableViewCell")
    }
}

extension EpisodeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource
        
    func tableView(_ tblView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tblView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
    
        switch indexPath.row {
            
        case EpisodeViewType.EpisodeViewType_EpisodeImage.rawValue:
            cell = self.getEpisodeImageDetailTableViewCell(tblView, indexPath: indexPath)
            
        case EpisodeViewType.EpisodeViewType_EpisodeDesc.rawValue:
            cell = self.getEpisodeDetailDescTableViewCell(tblView, indexPath: indexPath)
            
        default:
            return cell ?? UITableViewCell()
        }

        return cell ?? UITableViewCell()
    }

    
    //MARK: Table Helper Methods
    
    private func getEpisodeImageDetailTableViewCell(_ tblView: UITableView, indexPath: IndexPath) -> EpisodeImageDetailTableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "EpisodeImageDetailTableViewCell") as! EpisodeImageDetailTableViewCell
        cell.selectionStyle = .none

        if let episodeInfo = self.episodeInfo {
            cell.populateEpisodeImage(episodeInfo: episodeInfo)
        }
        
        return cell
    }
    
    private func getEpisodeDetailDescTableViewCell(_ tblView: UITableView, indexPath: IndexPath) -> EpisodeDetailDescTableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "EpisodeDetailDescTableViewCell") as! EpisodeDetailDescTableViewCell
        cell.selectionStyle = .none

        if let episodeInfo = self.episodeInfo {
            cell.populateEpisodeDetail(episodeInfo: episodeInfo)
        }

        return cell
    }
}
