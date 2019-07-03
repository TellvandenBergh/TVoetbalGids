////
////  ViewController.swift
////  isErVoetbalVanavond?
////
////  Created by Tell van den Bergh on 04/01/2019.
////  Copyright © 2019 Tell van den Bergh. All rights reserved.
////
//
//import UIKit
//
//import Foundation
//
//struct Wedstrijd: Decodable {
//    var datum: String
//    var tijd: String
//    var thuisTeam: String
//    var uitTeam: String
//    var zender: String
//    var leaugue: String
//}
//
//
//extension UIApplication {
//    var statusBarView: UIView? {
//        if responds(to: Selector(("statusBar"))) {
//            return value(forKey: "statusBar") as? UIView
//        }
//        return nil
//    }
//}
//
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getData()
//        getDates()
//        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: "myCell")
//        tableViewUI.backgroundColor = backgroundColor
//    }
//    
//    @IBOutlet weak var tableViewUI: UITableView!
//    
//    //  Colors
//    //  ---------
//    let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//    
//    let headerTitleColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
//    
//    let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    
//    let cellBackgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 0.8342786815)
//    
//    
//    //  getData
//    //  ---------
//    var wedstrijden = [Wedstrijd]()
//    @IBOutlet weak var tableView: UITableView!
//    
//    func getData() {
//        
//        let url = "https://raw.githubusercontent.com/TellvandenBergh/TellsJSON/master/testJSON"
//        let urlObj = URL(string: url)
//        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
//            
//            guard let data = data else { return }
//            do {
//                self.wedstrijden = try JSONDecoder().decode([Wedstrijd].self, from: data)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData() }
//            } catch let error { print("JSON parse ERROR", error) }
//            }.resume()
//    }
//    
//    
//    //  getDate
//    //  ---------
//    var datumVandaag = String()
//    var datumMorgen = String()
//    var datumOverMorgen = String()
//    var datum4 = String()
//    var datum5 = String()
//    var datum6 = String()
//    var datum7 = String()
//    var datum8 = String()
//    var datum9 = String()
//    
//    func getDates() {
//        
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.dateFormat = "dd/MM/yy"
//        
//        
//        var dateComponents = DateComponents()
//        dateComponents.setValue(1, for: .day); // +1 day
//        
//        let now = Date() // Current date
//        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
//        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow!)
//        let date4 = Calendar.current.date(byAdding: dateComponents, to: dayAfterTomorrow!)
//        let date5 = Calendar.current.date(byAdding: dateComponents, to: date4!)
//        let date6 = Calendar.current.date(byAdding: dateComponents, to: date5!)
//        let date7 = Calendar.current.date(byAdding: dateComponents, to: date6!)
//        let date8 = Calendar.current.date(byAdding: dateComponents, to: date7!)
//        let date9 = Calendar.current.date(byAdding: dateComponents, to: date8!)
//        
//        datumVandaag = formatter.string(from: Date())
//        datumMorgen = formatter.string(from: tomorrow!)
//        datumOverMorgen = formatter.string(from: dayAfterTomorrow!)
//        datum4 = formatter.string(from: date4!)
//        datum5 = formatter.string(from: date5!)
//        datum6 = formatter.string(from: date6!)
//        datum7 = formatter.string(from: date7!)
//        datum8 = formatter.string(from: date8!)
//        datum9 = formatter.string(from: date9!)
//    }
//    
//    //  makeTable
//    //  ----------
//    var WedstrijdenMetInhoud = [Array<Wedstrijd>]()
//    var alleWedstrijden = [Array<Wedstrijd>]()
//    var vandaag = [Wedstrijd]()
//    var morgen = [Wedstrijd]()
//    var overMorgen = [Wedstrijd]()
//    var dag4 = [Wedstrijd]()
//    var dag5 = [Wedstrijd]()
//    var dag6 = [Wedstrijd]()
//    var dag7 = [Wedstrijd]()
//    var dag8 = [Wedstrijd]()
//    var dag9 = [Wedstrijd]()
//    
//    
//    var rest = [Wedstrijd]()
//    let logos = Logos().logoDict
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        for wedstrijd in self.wedstrijden {
//            switch wedstrijd.datum {
//            case self.datumVandaag:
//                self.vandaag.append(wedstrijd)
//            case self.datumMorgen:
//                self.morgen.append(wedstrijd)
//            case self.datumOverMorgen:
//                self.overMorgen.append(wedstrijd)
//            case self.datum4:
//                self.dag4.append(wedstrijd)
//            case self.datum5:
//                self.dag5.append(wedstrijd)
//            case self.datum6:
//                self.dag6.append(wedstrijd)
//            case self.datum7:
//                self.dag7.append(wedstrijd)
//            case self.datum8:
//                self.dag8.append(wedstrijd)
//            case self.datum9:
//                self.dag9.append(wedstrijd)
//            default:
//                print("te veel")
//            }
//        }
//        self.WedstrijdenMetInhoud = [self.vandaag , self.morgen , self.overMorgen , self.dag4,self.dag5,self.dag6,self.dag7,self.dag8,self.dag9, self.rest]
//        
//        for dag in WedstrijdenMetInhoud {
//            var naam = String()
//            switch section {
//            case 0:
//                naam = "Vandaag"
//            case 1:
//                naam = "Morgen"
//            case 2:
//                naam = datumOverMorgen
//            case 3:
//                naam = datum4
//            case 4:
//                naam = datum5
//            case 5:
//                label.text = datum6
//            case 6:
//                label.text = datum7
//            case 7:
//                label.text = datum8
//            case 8:
//                label.text = datum9
//            default:
//                label.text = "Ooit"
//            }
//            if dag.count > 0 {
//                Section(sectionName: ,sectionObjects: dag, expanded: false)
//                alleWedstrijden.append(dag)
//            }
//        }
//        return alleWedstrijden.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return alleWedstrijden[section].count
//    }
//    
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let label = UILabel()
//        
//        UIApplication.shared.statusBarView?.backgroundColor = backgroundColor
//        view.backgroundColor = backgroundColor
//        label.frame = CGRect(x: 5, y: 1, width: 100, height: 35)
//        
//        
//        label.font = (UIFont.boldSystemFont(ofSize: 30))
//        label.textColor = headerTitleColor
//        label.adjustsFontSizeToFitWidth = true
//        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
//        
//        label.textAlignment = NSTextAlignment.center
//        
//        
//        view.addSubview(label)
//        
//        return view
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
//    
//    
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
//        
//        cell.Myinit(tijdLabel: alleWedstrijden[indexPath.section][indexPath.row].tijd,
//                    thuisTeamLabel: alleWedstrijden[indexPath.section][indexPath.row].thuisTeam,
//                    uitTeamLabel: alleWedstrijden[indexPath.section][indexPath.row].uitTeam,
//                    zenderLabel: alleWedstrijden[indexPath.section][indexPath.row].zender,
//                    thuisLogoImageName: logos[alleWedstrijden[indexPath.section][indexPath.row].thuisTeam] ?? "???.png",
//                    uitLogoImageName: logos[alleWedstrijden[indexPath.section][indexPath.row].uitTeam] ?? "???.png",
//                    logoImageName: alleWedstrijden[indexPath.section][indexPath.row].leaugue,
//                    backgroundName: ""
//        )
//        cell.background.backgroundColor = cellBackgroundColor
//        cell.cellBackground.backgroundColor = backgroundColor
//        cell.thuisTeamLabel.textColor = textColor
//        cell.uitTeamLabel.textColor = textColor
//        cell.tijdLabel.textColor = textColor
//        cell.zenderLabel.textColor = textColor
//        if alleWedstrijden[indexPath.section][indexPath.row].leaugue == "CL" {
//            cell.background.image = UIImage(named: "CL background")
//            cell.logoImage.isHidden = true
//            let color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            cell.thuisTeamLabel.textColor = color
//            cell.uitTeamLabel.textColor = color
//            cell.tijdLabel.textColor = color
//            cell.zenderLabel.textColor = color
//        }
//        
//        return cell
//    }
//    
//    
//}
//
//
