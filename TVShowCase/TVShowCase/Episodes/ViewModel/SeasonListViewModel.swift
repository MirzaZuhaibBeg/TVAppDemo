//
//  SeasonListViewModel.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import Foundation

protocol SeasonListViewModelProtocol: AnyObject {
   
    func populateSeasonList()
}

class SeasonListViewModel {
    
    weak var delegate: SeasonListViewModelProtocol?
    
    var seasonInfoArray: [SeasonInfo]?

    // apiService is mandatory for presenter to work, should be initialised in init
    fileprivate let apiService: APIServiceInteractor

    required init(service: APIServiceInteractor) {
        self.apiService = service
    }

    func attachView(view: SeasonListViewModelProtocol) {
        self.delegate = view
    }
    
    func getSeasonList(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.apiService.getSeasonInfoArray { data, error in
                
                DispatchQueue.main.async {
                    if let seasons = data as? [SeasonInfo] {
                        self.seasonInfoArray = seasons
                    }
                    self.delegate?.populateSeasonList()
                }
            }
        }
    }
}
