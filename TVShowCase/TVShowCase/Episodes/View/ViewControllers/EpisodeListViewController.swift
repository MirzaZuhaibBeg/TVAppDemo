//
//  EpisodeListViewController.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    // service should follow APIServiceInteractor protocol. For testing presenter, we can pass our own implementation of APIServiceInteractor which will give mocked data in place of API data
    var viewModel = SeasonListViewModel(service: APIService())

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
        self.viewModel.attachView(view: self)
        self.viewModel.getSeasonList()
    }
    
    //MARK: Helper Methods
    
    private func customizeView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.episodeNavigationTitle
        
        self.tableView.register(UINib(nibName: "EpisodeItemTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeItemTableViewCell")
    }
}

extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.seasonInfoArray?.count ?? 0
    }
    
    func tableView(_ tblView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let seasonInfoArray = self.viewModel.seasonInfoArray else {
            return 0
        }
        
        let seasonInfo = seasonInfoArray[section]
        let episodeInfoArray = seasonInfo.episodesInfoArray
        return episodeInfoArray?.count ?? 0
    }
    
    func tableView(_ tblView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "EpisodeItemTableViewCell") as! EpisodeItemTableViewCell
        
        guard let seasonInfoArray = self.viewModel.seasonInfoArray else {
            return cell
        }
        
        let seasonInfo = seasonInfoArray[indexPath.section]
        if let episodeInfoArray = seasonInfo.episodesInfoArray{
            cell.populateEpisodeInfo(episodeInfo:episodeInfoArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let seasonInfoArray = self.viewModel.seasonInfoArray else {
            return nil
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40.0))
        view.backgroundColor = UIColor.white

        let viewSeparator = UIView(frame: CGRect(x: 0, y: 39.0, width: tableView.bounds.size.width, height: 1.0))
        viewSeparator.backgroundColor = UIColor.black
        view.addSubview(viewSeparator)
        
        let lbl = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.bounds.size.width-20, height: 40.0))
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.black
        
        let seasonInfo = seasonInfoArray[section]
        if let seasonNumber = seasonInfo.seasonNumber {
            lbl.text = "Season: \(seasonNumber)"
        }
        
        view.addSubview(lbl)

        return view
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         
         guard let seasonInfoArray = self.viewModel.seasonInfoArray else {
             return
         }

         if let episodeDetailViewController: EpisodeDetailsViewController = Utils.getViewController(storyBoardName: Constants.storyBoardName, storyBoardId: "EpisodeDetailsViewController") as? EpisodeDetailsViewController {
             let seasonInfo = seasonInfoArray[indexPath.section]
             if let episodeInfoArray = seasonInfo.episodesInfoArray {
                 episodeDetailViewController.episodeInfo = episodeInfoArray[indexPath.row]
             }
             self.navigationController?.pushViewController(episodeDetailViewController, animated: true)
        }
    }
}

extension EpisodeListViewController: SeasonListViewModelProtocol {
    
    func populateSeasonList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
