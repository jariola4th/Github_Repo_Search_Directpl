//
//  Messages.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation

/// Message Constants
enum Message {
    
    // MARK: Network
    static let networkOnGoing = "Network in Process"
    static let networkSuccess = "Network has finished"
    static let networkSuccessEmpty = "No data available"
    static let networkFailed = "Network has encountered an error"
    
    // MARK: Error
    static let badRequestTitle = "Bad Request"
    static let unknownTitle = "Unknown Error"
    static let badRequestDescription = "Server was unable to process the request."
    static let unknownDescription = "There seems to be a problem. Please try again later."

}
