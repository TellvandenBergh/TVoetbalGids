//
//  ParseJSON.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 17/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

struct Match: Decodable {
  var datum: String
  var tijd: String
  var thuisTeam: String
  var uitTeam: String
  var zender: String
  var leaugue: String
}

class ParseJSON {
  private var wedstrijden = [Match]()
  
  // MARK: - Get Data
  func getData() -> [Match] {
    //let test = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/testJSON"
    let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/TVoetbalGidsJSON"
    let urlObj = URL(string: url)
    URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
      
      guard let data = data else { return }
      do {
        self.wedstrijden = try JSONDecoder().decode([Match].self, from: data)
        DispatchQueue.main.async {
          print(self.wedstrijden)
        }
      } catch let error { print("JSON parse ERROR", error) }
      }.resume()
    return wedstrijden
  }
}
