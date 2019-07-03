////
////  WedtrijdenData.swift
////  isErVoetbalVanavond?
////
////  Created by Tell van den Bergh on 06/02/2019.
////  Copyright © 2019 Tell van den Bergh. All rights reserved.
////
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
//class wedstrijdenData {
////    let mainVC = ViewController()
////    let clubView = ClubViewController()
//
//
//
//    func getWedstrijden() -> [[Wedstrijd]] {
//
//        makeWedstrijdArray()
//        return alleWedstrijden
//    }
//
//
//
//    // makeWedstrijdArray
//    // --------------------
//
//    var openZenders = [Wedstrijd]()
//    var ziggoSport = [Wedstrijd]()
//    var ziggoSportTotaal = [Wedstrijd]()
//    var foxSportsE = [Wedstrijd]()
//    var foxSportsI = [Wedstrijd]()
//
//    var wedstrijdenZenderSelect = [Wedstrijd]()
//
//    var vandaag = [Wedstrijd]()
//    var morgen = [Wedstrijd]()
//    var overMorgen = [Wedstrijd]()
//    var dag4 = [Wedstrijd]()
//    var dag5 = [Wedstrijd]()
//    var dag6 = [Wedstrijd]()
//    var dag7 = [Wedstrijd]()
//    var dag8 = [Wedstrijd]()
//    var dag9 = [Wedstrijd]()
//    var rest = [Wedstrijd]()
//
//    var WedstrijdenMetInhoud = [Array<Wedstrijd>]()
//    var alleWedstrijden = [Array<Wedstrijd>]()
//
//    func removeAll() {
//        openZenders.removeAll()
//        ziggoSport.removeAll()
//        ziggoSportTotaal.removeAll()
//        foxSportsE.removeAll()
//        foxSportsI.removeAll()
//
//        wedstrijdenZenderSelect.removeAll()
//
//        vandaag.removeAll()
//        morgen.removeAll()
//        overMorgen.removeAll()
//        dag4.removeAll()
//        dag5.removeAll()
//        dag6.removeAll()
//        dag7.removeAll()
//        dag8.removeAll()
//        dag9.removeAll()
//        rest.removeAll()
//
//        alleWedstrijden.removeAll()
//        WedstrijdenMetInhoud.removeAll()
//
//    }
//
//    var wedstrijden = [Wedstrijd]()
//
//    func makeWedstrijdArray() {
//        getDates()
//        talkToZenders()
//
//        wedstrijden = ViewController().wedstrijden
//
//        removeAll()
//
//        for wedstrijd in wedstrijden {
//            switch wedstrijd.zender {
//            case "Ziggo Sport":
//                ziggoSport.append(wedstrijd)
//            case "Ziggo Sport Voetbal","Ziggo Sport Golf","Ziggo Sport Racing","Ziggo Sport Docu","Ziggo Sport Extra":
//                ziggoSportTotaal.append(wedstrijd)
//            case "Fox Sports 1","Fox Sports 2","Fox Sports 3","Fox Sports 7","Fox Sports 8","Fox Sports 9":
//                foxSportsE.append(wedstrijd)
//            case "Fox Sports 4","Fox Sports 5","Fox Sports 6":
//                foxSportsI.append(wedstrijd)
//            default:
//                openZenders.append(wedstrijd)
//            }
//        }
//
//
//        if ziggoSportIsOn {
//            wedstrijdenZenderSelect += ziggoSport
//        }
//        if ziggoSportTotaalIsOn {
//            wedstrijdenZenderSelect += ziggoSportTotaal
//        }
//        if foxSportsEredivisieIsOn {
//            wedstrijdenZenderSelect += foxSportsE
//        }
//        if foxSportsInternationaalIsOn {
//            wedstrijdenZenderSelect += foxSportsI
//        }
//        wedstrijdenZenderSelect += openZenders
//
//
//        for wedstrijd in wedstrijdenZenderSelect {
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
//        WedstrijdenMetInhoud.removeAll()
//        self.WedstrijdenMetInhoud = [self.vandaag , self.morgen , self.overMorgen , self.dag4,self.dag5,self.dag6,self.dag7,self.dag8,self.dag9, self.rest]
//
//        for dag in WedstrijdenMetInhoud {
//            if dag.count > 0 {
//                alleWedstrijden.append(dag)
//            }
//
//        }
//    }
//
//    //  getDate
//    //  ---------
//    private var datumVandaag = String()
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
//        var dateComponents = DateComponents()
//        dateComponents.setValue(1, for: .day); // +1 day
//
//        let now = Date()
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
//
//    }
//
//    // talkToZenders
//    // -----------------
//
//    let defaults = UserDefaults.standard
//
//    var ziggoSportIsOn = Bool()
//    var ziggoSportTotaalIsOn = Bool()
//    var foxSportsEredivisieIsOn = Bool()
//    var foxSportsInternationaalIsOn = Bool()
//
//    func talkToZenders() {
//        if defaults.value(forKey: "ziggoSportIsAan") != nil{
//            let ziggoSportIsAan: Bool = defaults.value(forKey: "ziggoSportIsAan")  as! Bool
//            if ziggoSportIsAan == true{
//                ziggoSportIsOn = true
//            }
//            else if ziggoSportIsAan == false{
//                ziggoSportIsOn = false
//            }
//        } else {
//            ziggoSportIsOn = true
//        }
//
//        if defaults.value(forKey: "ziggoSportTotaalIsAan") != nil{
//            let ziggoSportTotaalIsAan: Bool = defaults.value(forKey: "ziggoSportTotaalIsAan")  as! Bool
//            if ziggoSportTotaalIsAan == true{
//                ziggoSportTotaalIsOn = true
//            }
//            else if ziggoSportTotaalIsAan == false{
//                ziggoSportTotaalIsOn = false
//            }
//        } else {
//            ziggoSportTotaalIsOn = true
//        }
//
//        if defaults.value(forKey: "foxSportsEredivisieIsAan") != nil{
//            let foxSportsEredivisieIsAan: Bool = defaults.value(forKey: "foxSportsEredivisieIsAan")  as! Bool
//            if foxSportsEredivisieIsAan == true{
//                foxSportsEredivisieIsOn = true
//            }
//            else if foxSportsEredivisieIsAan == false{
//                foxSportsEredivisieIsOn = false
//            }
//        } else {
//            foxSportsEredivisieIsOn = true
//        }
//
//        if defaults.value(forKey: "foxSportsInternationaalIsAan") != nil{
//            let foxSportsInternationaalIsAan: Bool = defaults.value(forKey: "foxSportsInternationaalIsAan")  as! Bool
//            if foxSportsInternationaalIsAan == true{
//                foxSportsInternationaalIsOn = true
//            }
//            else if foxSportsInternationaalIsAan == false{
//                foxSportsInternationaalIsOn = false
//            }
//        } else {
//            foxSportsInternationaalIsOn = true
//        }
//    }
//
//
//
//
//
//}
//
