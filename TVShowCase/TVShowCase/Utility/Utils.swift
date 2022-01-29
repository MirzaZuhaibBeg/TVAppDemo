//
//  Constants.swift
//  TVShowCase
//
//  Created by Yasmin Tahira on 2022-01-29.
//


import Foundation
import UIKit

class Utils {
    
    static let sharedUtils = Utils()
    
    public class func getViewController(storyBoardName:String?, storyBoardId:String?) -> Any? {
        
        var viewController:Any? = nil
        
        if let storyBoardId = storyBoardId, let storyBoardName = storyBoardName {
            let storyboard = UIStoryboard(name:storyBoardName, bundle: nil)
            viewController  = storyboard.instantiateViewController(withIdentifier:storyBoardId)
        }
        return viewController
    }    
}

