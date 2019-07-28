//
//  parseJSON.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 26/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

class parseJSON {
  
  private var matches = [Match]()
  public var myProtocol: jsonIsParsedProtocol?
  
  public func parseJSON()  {
    let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/testJSON" // test JSON
    // let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/TVoetbalGidsJSON"
    guard let urlObj = URL(string: url) else { return }
    URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
      DispatchQueue.main.async {
        if let error = error { print("JSON parse ERROR", error)
          return }
      }
      guard let data = data else { return }
      do {
        self.matches = try JSONDecoder().decode([Match].self, from: data)
        self.myProtocol?.jsonIsParsed(jsonDidParse: true, parsedJsonData: self.matches)
      } catch let error { print("JSON parse ERROR", error) }
      }.resume()
  }
}
