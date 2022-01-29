//
//  NetworkManager.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//

import Foundation

enum LocalDataRequestType: String {
    case LocalDataRequestType_SeasonInfo = "silicon-valley"
}

class DatakManager {
    
    internal typealias CompletionClosure = (_ data:Data?, _ error: Error?) -> Void
    
    func getDataFromLocalJSON(requestType: LocalDataRequestType, withCompletionBlock completion: @escaping CompletionClosure) {
        
        guard let filepath =  Bundle.main.path(forResource: requestType.rawValue, ofType: "json") else {
            completion(nil,nil)
            return
        }
        
        do {
            let contents = try String(contentsOfFile: filepath)
            
            #if DEBUG
            print("contents")
            print(contents)
            #else
       
            #endif

            let data = contents.data(using: .utf8)!
            completion(data, nil)
            
        } catch {
            completion(nil,nil)
        }
    }
}
