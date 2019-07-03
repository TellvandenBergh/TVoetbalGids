//
//  ViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 04/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

import Foundation


struct Wedstrijd: Decodable {
  var datum: String
  var tijd: String
  var thuisTeam: String
  var uitTeam: String
  var zender: String
  var leaugue: String
}


extension UIApplication {
  var statusBarView: UIView? {
    if responds(to: Selector(("statusBar"))) {
      return value(forKey: "statusBar") as? UIView
    }
    return nil
  }
}

let setDefaults = UserDefaults.standard


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ziggoSportIsOn = true
    ziggoSportTotaalIsOn = true
    foxSportsEredivisieIsOn = true
    foxSportsInternationaalIsOn = true
    getData()
    getDates()
    backgroundTransition()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    talkToZenders()
    makeWedstrijdArray()
    talkToClubSelect()
    backgroundTransition()
    tableView.reloadData()
  }
  
  override func awakeFromNib() {
    print("jaHooor")
  }
  
  
  let clubNamen = Logos()
  var clubsArray = [String]()
  var filteredArray = [String]()
  var shouldShowSearchResults = false
  @IBOutlet weak var background: UIImageView!
  
  //  getData
  //  ---------
  var wedstrijden = [Wedstrijd]()
  
  func getData() {
    let test = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/testJSON"
    let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/TVoetbalGidsJSON"
    let urlObj = URL(string: url)
    URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
      
      guard let data = data else { return }
      do {
        self.wedstrijden = try JSONDecoder().decode([Wedstrijd].self, from: data)
        DispatchQueue.main.async {
          self.tableView.reloadData() }
      } catch let error { print("JSON parse ERROR", error) }
      }.resume()
  }
  
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func selector(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      mijnTeamsIsOn = false
      tableView.reloadData()
    } else {
      mijnTeamsIsOn = true
      tableView.reloadData()
    }
  }
  
  //wat zijn de favoriete teams
  //--------------------
  
  var selectedClubs = [String]()
  
  func talkToClubSelect() {
    selectedClubs = setDefaults.array(forKey: "selectedClubsKey") as? [String] ?? [""]
  }
  
  
  
  // Welke zenders zijn ingesteld
  // --------------
  
  var ziggoSportIsOn = Bool()
  var ziggoSportTotaalIsOn = Bool()
  var foxSportsEredivisieIsOn = Bool()
  var foxSportsInternationaalIsOn = Bool()
  
  func talkToZenders() {
    if setDefaults.value(forKey: "ziggoSportIsAan") != nil{
      let ziggoSportIsAan: Bool = setDefaults.value(forKey: "ziggoSportIsAan")  as! Bool
      if ziggoSportIsAan == true{
        ziggoSportIsOn = true
      }
      else if ziggoSportIsAan == false{
        ziggoSportIsOn = false
      }
    } else {
      ziggoSportIsOn = true
    }
    
    if setDefaults.value(forKey: "ziggoSportTotaalIsAan") != nil{
      let ziggoSportTotaalIsAan: Bool = setDefaults.value(forKey: "ziggoSportTotaalIsAan")  as! Bool
      if ziggoSportTotaalIsAan == true{
        ziggoSportTotaalIsOn = true
      }
      else if ziggoSportTotaalIsAan == false{
        ziggoSportTotaalIsOn = false
      }
    } else {
      ziggoSportTotaalIsOn = true
    }
    
    if setDefaults.value(forKey: "foxSportsEredivisieIsAan") != nil{
      let foxSportsEredivisieIsAan: Bool = setDefaults.value(forKey: "foxSportsEredivisieIsAan")  as! Bool
      if foxSportsEredivisieIsAan == true{
        foxSportsEredivisieIsOn = true
      }
      else if foxSportsEredivisieIsAan == false{
        foxSportsEredivisieIsOn = false
      }
    } else {
      foxSportsEredivisieIsOn = true
    }
    
    if setDefaults.value(forKey: "foxSportsInternationaalIsAan") != nil{
      let foxSportsInternationaalIsAan: Bool = setDefaults.value(forKey: "foxSportsInternationaalIsAan")  as! Bool
      if foxSportsInternationaalIsAan == true{
        foxSportsInternationaalIsOn = true
      }
      else if foxSportsInternationaalIsAan == false{
        foxSportsInternationaalIsOn = false
      }
    } else {
      foxSportsInternationaalIsOn = true
    }
  }
  
  
  //  Colors
  //  ---------
  
  let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
  
  let statusbarcolor = #colorLiteral(red: 0.1808597445, green: 0.1964799166, blue: 0.2174212337, alpha: 0)
  
  let headerTitleColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
  
  let textColor = #colorLiteral(red: 0.9688113332, green: 0.9777501225, blue: 1, alpha: 0.584572988)
  
  let cellBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
  
  let blurCellBackgroundColor = #colorLiteral(red: 0.7882352941, green: 0.8078431373, blue: 0.968627451, alpha: 0.1998341181)
  
  
  
  
  
  //  getDate
  //  ---------
  var datumVandaag = String()
  var datumMorgen = String()
  var datumOverMorgen = String()
  var datum4 = String()
  var datum5 = String()
  var datum6 = String()
  var datum7 = String()
  var datum8 = String()
  var datum9 = String()
  
  
  
  func getDates() {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd-MM"
    
    var dateComponents = DateComponents()
    dateComponents.setValue(1, for: .day); // +1 day
    
    let now = Date() // Current date
    let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
    let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow!)
    let date4 = Calendar.current.date(byAdding: dateComponents, to: dayAfterTomorrow!)
    let date5 = Calendar.current.date(byAdding: dateComponents, to: date4!)
    let date6 = Calendar.current.date(byAdding: dateComponents, to: date5!)
    let date7 = Calendar.current.date(byAdding: dateComponents, to: date6!)
    let date8 = Calendar.current.date(byAdding: dateComponents, to: date7!)
    let date9 = Calendar.current.date(byAdding: dateComponents, to: date8!)
    
    datumVandaag = formatter.string(from: Date())
    datumMorgen = formatter.string(from: tomorrow!)
    datumOverMorgen = formatter.string(from: dayAfterTomorrow!)
    datum4 = formatter.string(from: date4!)
    datum5 = formatter.string(from: date5!)
    datum6 = formatter.string(from: date6!)
    datum7 = formatter.string(from: date7!)
    datum8 = formatter.string(from: date8!)
    datum9 = formatter.string(from: date9!)
  }
  
  // sort
  // ------------------
  
  func SortByTime(unsortedArray: [Wedstrijd]) -> [Wedstrijd] {
    let sortedArray = unsortedArray.sorted(by: { $0.tijd < $1.tijd})
    return sortedArray
  }
  // makeWedstrijdArray
  // --------------------
  
  var openZenders = [Wedstrijd]()
  var ziggoSport = [Wedstrijd]()
  var ziggoSportTotaal = [Wedstrijd]()
  var foxSportsE = [Wedstrijd]()
  var foxSportsI = [Wedstrijd]()
  
  var wedstrijdenZenderSelect = [Wedstrijd]()
  var wedstrijdenClubSelect = [Wedstrijd]()
  
  var vandaag = [Wedstrijd]()
  var advertentie = [Wedstrijd]()
  var morgen = [Wedstrijd]()
  var overMorgen = [Wedstrijd]()
  var dag4 = [Wedstrijd]()
  var dag5 = [Wedstrijd]()
  var dag6 = [Wedstrijd]()
  var dag7 = [Wedstrijd]()
  var dag8 = [Wedstrijd]()
  var dag9 = [Wedstrijd]()
  var rest = [Wedstrijd]()
  
  var mijnTeamsIsOn = Bool()
  
  
  var WedstrijdenMetInhoud = [Array<Wedstrijd>]()
  var WedstrijdenZonderAd = [Array<Wedstrijd>]()
  var alleWedstrijden = [Array<Wedstrijd>]()
  
  func removeAll() {
    openZenders.removeAll()
    ziggoSport.removeAll()
    ziggoSportTotaal.removeAll()
    foxSportsE.removeAll()
    foxSportsI.removeAll()
    
    wedstrijdenZenderSelect.removeAll()
    wedstrijdenClubSelect.removeAll()
    
    vandaag.removeAll()
    morgen.removeAll()
    overMorgen.removeAll()
    dag4.removeAll()
    dag5.removeAll()
    dag6.removeAll()
    dag7.removeAll()
    dag8.removeAll()
    dag9.removeAll()
    rest.removeAll()
    
    alleWedstrijden.removeAll()
    WedstrijdenZonderAd.removeAll()
    WedstrijdenMetInhoud.removeAll()
  }
  
  func makeWedstrijdArray() {
    
    removeAll()
    
    // filter zenders
    for wedstrijd in self.wedstrijden {
      switch wedstrijd.zender {
      case "Ziggo Sport":
        ziggoSport.append(wedstrijd)
      case "Ziggo Sport Voetbal","Ziggo Sport Golf","Ziggo Sport Racing","Ziggo Sport Docu","Ziggo Sport Extra":
        ziggoSportTotaal.append(wedstrijd)
      case "Fox Sports 1","Fox Sports 2","Fox Sports 3","Fox Sports 7","Fox Sports 8","Fox Sports 9":
        foxSportsE.append(wedstrijd)
      case "Fox Sports 4","Fox Sports 5","Fox Sports 6":
        foxSportsI.append(wedstrijd)
      default:
        openZenders.append(wedstrijd)
      }
    }
    
    
    // zijn de zenders geselecteerd
    if ziggoSportIsOn {
      wedstrijdenZenderSelect += ziggoSport
    }
    if ziggoSportTotaalIsOn {
      wedstrijdenZenderSelect += ziggoSportTotaal
    }
    if foxSportsEredivisieIsOn {
      wedstrijdenZenderSelect += foxSportsE
    }
    if foxSportsInternationaalIsOn {
      wedstrijdenZenderSelect += foxSportsI
    }
    wedstrijdenZenderSelect += openZenders
    
    
    
    // verander tabel als clubSelectIsOn
    if mijnTeamsIsOn {
      for wedstrijd in wedstrijdenZenderSelect {
        for selectWedstrijd in selectedClubs {
          if wedstrijd.thuisTeam == selectWedstrijd || wedstrijd.uitTeam == selectWedstrijd {
            
            wedstrijdenClubSelect.append(wedstrijd)
          }
        }
      }
      wedstrijdenZenderSelect.removeAll()
      wedstrijdenZenderSelect = wedstrijdenClubSelect
      
      
      // verwijder dubbele wedstrijden
      var cellDict = [String : Wedstrijd]()
      for wed in wedstrijdenZenderSelect {
        cellDict["\(wed.thuisTeam)\(wed.datum)"] = wed
      }
      wedstrijdenZenderSelect.removeAll()
      for wed in cellDict {
        wedstrijdenZenderSelect.append(wed.value)
      }
    }
    
    
    // filter Datums
    for wedstrijd in wedstrijdenZenderSelect {
      switch wedstrijd.datum {
      case self.datumVandaag:
        self.vandaag.append(wedstrijd)
      case self.datumMorgen:
        self.morgen.append(wedstrijd)
      case self.datumOverMorgen:
        self.overMorgen.append(wedstrijd)
      case self.datum4:
        self.dag4.append(wedstrijd)
      case self.datum5:
        self.dag5.append(wedstrijd)
      case self.datum6:
        self.dag6.append(wedstrijd)
      case self.datum7:
        self.dag7.append(wedstrijd)
      case self.datum8:
        self.dag8.append(wedstrijd)
      case self.datum9:
        self.dag9.append(wedstrijd)
      default:
        print("Datum ERROR")
      }
    }
    
    self.WedstrijdenMetInhoud = [self.vandaag ,self.advertentie, self.morgen , self.overMorgen , self.dag4,self.dag5,self.dag6,self.dag7,self.dag8,self.dag9, self.rest]
    
    
    // filter lege datum & sorteer arrays
    for dag in WedstrijdenMetInhoud {
      if dag.count > 0 {
        let sortedDag = dag.sorted(by: { $0.tijd < $1.tijd})
        alleWedstrijden.append(sortedDag)
      }
    }
    
    let advertentie = [Wedstrijd(datum: "", tijd: "", thuisTeam: "", uitTeam: "", zender: "", leaugue: "AD")]
    if alleWedstrijden.count != 0 {
    alleWedstrijden.insert(advertentie, at: 1)
    }
  }
  
  
  //  makeTable
  //  ----------
  
  let logos = Logos().logoDict
  
  func numberOfSections(in tableView: UITableView) -> Int {
    makeWedstrijdArray()
   return alleWedstrijden.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alleWedstrijden[section].count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    let label = UILabel()
    
    
    UIApplication.shared.statusBarView?.backgroundColor = statusbarcolor
    view.backgroundColor = backgroundColor
    label.frame = CGRect(x: 30 , y: 0, width: 300, height: 35)
    label.font = (UIFont.boldSystemFont(ofSize: 30))
    label.textColor = headerTitleColor
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = NSTextAlignment.left
    
    
    switch section {
    case 0:
      if alleWedstrijden[0][0].datum == datumVandaag {
        label.text = "Vandaag"
      } else {
        label.text = "\(alleWedstrijden[0][0].datum)" }
    case 1:
      label.text = "Advertisement"
      label.font = (UIFont.boldSystemFont(ofSize: 12))
      label.frame = CGRect(x: 15 , y: 15, width: 300, height: 35)
    case 2:
      if alleWedstrijden[2][0].datum == datumMorgen {
        label.text = "Morgen"
      } else {
        label.text = "\(alleWedstrijden[2][0].datum)" }
    case 3:
      label.text = "\(alleWedstrijden[3][0].datum)"
    case 4:
      label.text = "\(alleWedstrijden[4][0].datum)"
    case 5:
      label.text = "\(alleWedstrijden[5][0].datum)"
    case 6:
      label.text = "\(alleWedstrijden[6][0].datum)"
    case 7:
      label.text = "\(alleWedstrijden[7][0].datum)"
    case 8:
      label.text = "\(alleWedstrijden[8][0].datum)"
    case 9:
      label.text = "\(alleWedstrijden[9][0].datum)"
    default:
      label.text = ""
      
    }

    
    view.addSubview(label)
    
    
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nibName = UINib(nibName: "TableViewCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "myCell")
    tableView.backgroundColor = backgroundColor
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
    
    let nibName2 = UINib(nibName: "vanNoorCell", bundle: nil)
    tableView.register(nibName2, forCellReuseIdentifier: "vanNoor")
    let cell2 = tableView.dequeueReusableCell(withIdentifier: "vanNoor", for: indexPath) as! Ad
    
    cell.Myinit(tijdLabel: alleWedstrijden[indexPath.section][indexPath.row].tijd,
                zenderLabel: alleWedstrijden[indexPath.section][indexPath.row].zender,
                thuisLabel:alleWedstrijden[indexPath.section][indexPath.row].thuisTeam,
                uitLabel:alleWedstrijden[indexPath.section][indexPath.row].uitTeam,
                thuisLogoImageName:Logos().logoDict[alleWedstrijden[indexPath.section][indexPath.row].thuisTeam] ?? "noLogo.png",
                uitLogoImageName: Logos().logoDict[alleWedstrijden[indexPath.section][indexPath.row].uitTeam] ?? "noLogo.png",
                logoImageName: alleWedstrijden[indexPath.section][indexPath.row].leaugue,
                backgroundName: ""
    )
    
    cell.tijdLabel.textColor = textColor
    cell.thuisLabel.textColor = textColor
    cell.uitLabel.textColor = textColor
    cell.visualEffectView.backgroundColor = blurCellBackgroundColor
    cell.background.backgroundColor = cellBackgroundColor
    cell.cellBackground.backgroundColor = backgroundColor
    cell.zenderLabel.textColor = textColor
    if alleWedstrijden[indexPath.section][indexPath.row].leaugue == "CL" {
      cell.background.image = UIImage(named: "CL2")
      cell.background.alpha = 0.7
      let color = #colorLiteral(red: 0.9254969954, green: 0.9199952483, blue: 0.9297260642, alpha: 1)
      cell.tijdLabel.textColor = color
      cell.zenderLabel.textColor = color
    }
    
    
    if UIScreen.main.bounds.width < 567 {
      cell.thuisLabel.isHidden = true
      cell.uitLabel.isHidden = true
    } else {
      cell.thuisLabel.isHidden = false
      cell.uitLabel.isHidden = false
    }
    
          if alleWedstrijden[indexPath.section][indexPath.row].leaugue == "AD" {
            return cell2
          } else {
            return cell
          }
 
  }
  
  
  func backgroundTransition() {
    if UIScreen.main.bounds.width < 567 {
      background.isHidden = false
    } else {
      background.isHidden = true
    }
  }
  
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { _ in
      self.tableView.reloadData()
      self.backgroundTransition()
    }
  }
  
}
