//
//  XCTestCase.swift
//  Github_Repo_Search_DirectplTests
//
//  Created by Joyce on 9/28/21.
//

@testable import Github_Repo_Search_Directpl
import Foundation
import XCTest
import SwiftyJSON


extension XCTestCase {
    enum TestError: Error {
      case fileNotFound
    }
    
    func getJson(fromJSON fileName: String) throws -> JSON {
      let bundle = Bundle(for: type(of: self))
      guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        XCTFail("Missing File: \(fileName).json")
        throw TestError.fileNotFound
      }
      do {
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)[RepositoryKey.items]
        
        return json
      } catch {
        throw error
      }
        
    }
    
}
