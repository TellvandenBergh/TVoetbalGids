//
//  TableViewData.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 16/07/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import Foundation

class TableViewData {
  
  func getData() -> [Wedstrijd] {
    var wedstrijden = [Wedstrijd]()
    let test = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/testJSON"
    let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/TVoetbalGidsJSON"
    let urlObj = URL(string: url)
    URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
      
      guard let data = data else { return }
      do { wedstrijden = try JSONDecoder().decode([Wedstrijd].self, from: data)
      } catch let error { print("JSON parse ERROR", error) }
      }.resume()
    print(wedstrijden)
    return wedstrijden
  }
  
}
