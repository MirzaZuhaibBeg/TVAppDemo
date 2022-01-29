//
//  APIHelper.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import Foundation

internal typealias ServiceCompletionClosure = (_ data:Any?, _ error: Error?) -> Void

protocol APIServiceInteractor {
    
    func getSeasonInfoArray(withCompletionBlock completion: @escaping ServiceCompletionClosure)
}

class APIService: APIServiceInteractor{

    internal typealias ParseDataCompletionBlock = (_ success: Bool, _ data: Any?, _ error: Error?) -> Void

    func getSeasonInfoArray(withCompletionBlock completion: @escaping ServiceCompletionClosure) {
        
        let dataManager = DatakManager()
        dataManager.getDataFromLocalJSON(requestType: .LocalDataRequestType_SeasonInfo) { data, error in
            
            self.parseData(withData: data) { success, data, error in
                if let data = data as? [String: Any], let seasons = data["seasons"] as? [[String: Any]] {
                    let seasonInfoArray = SeasonInfo.getSeasonInfoArray(seasons: seasons)
                    completion(seasonInfoArray, nil)
                } else {
                    completion(nil, nil)
                }
            }
        }
    }
    
    //MARK: Private Methods
    
    private func parseData(withData data: Data?, completionHandler: @escaping ParseDataCompletionBlock) {
        
        guard let data = data else {
            completionHandler(false, nil, nil)
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            if let json = json {
                
                #if DEBUG
                print("json")
                print(json)

                #else
           
                #endif
                
                completionHandler(true, json, nil)
            } else {
                completionHandler(false, nil, nil)
            }
        } catch let error {
            completionHandler(false, nil, error)
        }
    }
}
