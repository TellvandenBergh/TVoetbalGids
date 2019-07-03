//
//  ClubViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 01/02/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit

struct cellData: Codable {
    var imageName : String?
    var clubName : String?
    var isSelected : Bool
}

class ClubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        loadTableViewData()
        exchangeMijnTeamData()
        setUpTextfield()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    
// Variables
// ------------------------------------------------------------------------------------------
    
    var tableViewData = [cellData]() // holds data used for tableview
    
    var selectArray =   [cellData]() // array with selected cells
    var saveArray =     [cellData]() // array with everything
    
    var selectDict =    [String : cellData]() //
    var saveDict =      [String : cellData]() // Dictionariys used for saving
    
    var selectedClubsString = [String]() // Array that will be saved
    
    var selectieIsOn = false
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    
    
    
// functions
// ------------------------------------------------------------------------------------------
    
    // set up search bar
    func setUpTextfield() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    func getData() {
        let clubNames = Logos()
        var unsortedData = [cellData]()
        var sortedData = [cellData]()
        
        for logoData in clubNames.logoDict {
            unsortedData.append(cellData(imageName: logoData.value, clubName: logoData.key, isSelected: false))
        }
            sortedData = unsortedData.sorted(by: { $0.clubName! < $1.clubName!})
        for club in sortedData {
            saveDict[club.clubName!] = club
        }
        tableViewData = Array(saveDict.values).sorted(by: { $0.clubName! < $1.clubName!})
    }
    
    // save selected clubs array
    func saveSelect(_ cell: [cellData]) {
        let dataSave = cell.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(dataSave, forKey: "dataSelectKey")
    }
    
    // saves everything array
    func saveData(_ cell: [cellData]) {
        let dataSave = cell.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(dataSave, forKey: "saveArrayKey")
    }
    
    
    
    // func to load selected clubs
    func loadselect() -> [cellData] {
        guard let encodedData = UserDefaults.standard.array(forKey: "dataSelectKey") as? [Data] else {
            return []
        }
        let saveData = encodedData.map { try! JSONDecoder().decode(cellData.self, from: $0) }
        
        return saveData
    }
    
    // func to load everything
    func loadData() -> [cellData] {
        guard let encodedData = UserDefaults.standard.array(forKey: "saveArrayKey") as? [Data] else {
            return []
        }
        let saveData = encodedData.map { try! JSONDecoder().decode(cellData.self, from: $0) }
        
        return saveData
    }
    
    
    func save() {
        // save [String] for selection in ViewContoller
        let selectedClubs = selectDict.values
        selectedClubsString.removeAll()
        for cell in selectedClubs {
            selectedClubsString.append(cell.clubName!)
        }
        setDefaults.set(selectedClubsString, forKey: "selectedClubsKey")
        
        
        selectArray.removeAll()
        for data in selectDict {
            selectArray.append(data.value)
        }
        saveSelect(selectArray)
        
        saveArray.removeAll()
        for data in saveDict {
            saveArray.append(data.value)
        }
        saveData(saveArray)
    }
    
    
    func loadTableViewData() {
        selectArray = loadselect().sorted(by: { $0.clubName! < $1.clubName!})
        saveArray = loadData().sorted(by: { $0.clubName! < $1.clubName!})
        tableViewData = saveArray
        
        for data in selectArray {
            selectDict[data.clubName!] = data
        }
        
        for data in saveArray {
            saveDict[data.clubName!] = data
        }
        
        if tableViewData.count == 0 {
            save()
            tableView.reloadData()
        }

    }
    
    
 
    func exchangeMijnTeamData() { // swaps data from "Alles"" to "Mijn Team" and back
        
        var unsortedData = [cellData]()
        
        tableViewData.removeAll()
        
        if selectieIsOn {
            unsortedData = loadselect()
        } else {
            unsortedData = loadData()
        }
        tableViewData = unsortedData.sorted(by: { $0.clubName! < $1.clubName!})
    }
    
    func backgroundTransition() { // sets backround for narrow or wide screens
        if UIScreen.main.bounds.width < 567 /*iphone 5/SE portrait size */ {
            background.isHidden = false
        } else {
            background.isHidden = true
        }
    }
    
    // detects screen rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.backgroundTransition()
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundTransition()
        self.tableView.reloadData()
    }
    

    
    
//  Colors & vissualEffect alpha
//  ------------------------------------------------------------------------------------------
    
    let cellColor = #colorLiteral(red: 0.9107066989, green: 0.9180753231, blue: 0.9578188062, alpha: 0.1998341181)
    let selectedCellColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 0.1685038527)
    
    let cellAlpha: CGFloat = 0.75
    let selectedAlpha: CGFloat = 1
    
    
// SearchBar
// ------------------------------------------------------------------------------------------
    
    var searchString = [String]()
    var dataSearch = [String : cellData]() // used in searchbar func

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else { tableView.reloadData() ; return }
       
        searchString = saveDict.keys.filter({$0.prefix(searchText.count) == searchText})
        
        tableViewData.removeAll()
        dataSearch.removeAll()
        
        for club in searchString {
            dataSearch[club] = saveDict[club]
        }
        
        for data in dataSearch {
            tableViewData.append(data.value)
        }
    
        tableView.reloadData()
        
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
//  makeTable
//  ----------------------------------------------------------------------------------
    
    let logos = Logos().logoDict
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    // Header button and segmented control functions
    //---------------------------------------------------------------------------------
    var selectionindex = 0
    @objc func segmentControlfunc(sender: UISegmentedControl!) {
                if sender.selectedSegmentIndex == 0 {
                    selectieIsOn = false
                    selectionindex = 0
                } else {
                    selectieIsOn = true
                    selectionindex = 1
                }
                save()
                exchangeMijnTeamData()
                tableView.reloadData()
        }

    @objc func resetfunc(sender: UIButton!) {
        UserDefaults.standard.removeObject(forKey: "saveArrayKey")
        UserDefaults.standard.removeObject(forKey: "dataSelectKey")
        saveDict.removeAll()
        selectDict.removeAll()
        getData()
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        let framewidth = tableView.frame.width
        let buttonWith = (framewidth / 3) - 20
        
        // Button
        let resetButton = UIButton(type: .system)
        resetButton.isUserInteractionEnabled = true
        resetButton.frame = CGRect(x: 20, y: 0, width: buttonWith , height: 30)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(#colorLiteral(red: 0.02117113583, green: 0.03491377458, blue: 0.102589108, alpha: 1), for: .normal)
        resetButton.layer.cornerRadius = 4
        resetButton.backgroundColor = #colorLiteral(red: 0.9412898421, green: 0.9590497613, blue: 1, alpha: 0.5521190068)
        resetButton.addTarget(self, action: #selector(resetfunc(sender:)), for: .touchUpInside)

       
        // SegmentedControll
        let segmentedControlNames = ["Alles" , "Mijn Teams"]
        let segmentedControl = UISegmentedControl(items: segmentedControlNames)
        
        segmentedControl.frame = CGRect(x: buttonWith + 40 , y: 0 , width: buttonWith * 2, height: 30)
        segmentedControl.selectedSegmentIndex = selectionindex
        segmentedControl.clipsToBounds = false
        segmentedControl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        segmentedControl.tintColor = #colorLiteral(red: 0.9412898421, green: 0.9590497613, blue: 1, alpha: 0.5521190068)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        segmentedControl.addTarget(self, action: #selector(segmentControlfunc(sender:)), for: .valueChanged)
        
        if section == 0 {
            view.addSubview(resetButton)
            view.addSubview(segmentedControl)
        }
       
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let nibName = UINib(nibName: "CellForClubNamen", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "clubCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath) as! CellForClubNamen
        
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        
        if tableViewData[indexPath.row].isSelected {
            cell.visualEffectView.backgroundColor = selectedCellColor
            cell.visualEffectView.alpha = selectedAlpha
        } else {
            cell.visualEffectView.backgroundColor = cellColor
            cell.visualEffectView.alpha = cellAlpha
        }
        
        cell.Myinit(imageName: tableViewData[indexPath.row].imageName ?? "??", labelName: tableViewData[indexPath.row].clubName ?? "??")

        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CellForClubNamen
        cell.selectionStyle = .none
        
        if saveDict[cell.labelOutlet.text!]!.isSelected {
            cell.visualEffectView.backgroundColor = cellColor
            cell.visualEffectView.alpha = cellAlpha
            saveDict[cell.labelOutlet.text!]!.isSelected = false
            selectDict[cell.labelOutlet.text!]!.isSelected = false
            selectDict.removeValue(forKey: cell.labelOutlet.text!)
        } else {
            cell.visualEffectView.backgroundColor = selectedCellColor
            cell.visualEffectView.alpha = selectedAlpha
            saveDict[cell.labelOutlet.text!]!.isSelected = true
            selectDict[cell.labelOutlet.text!] = saveDict[cell.labelOutlet.text!]
            selectDict[cell.labelOutlet.text!]!.isSelected = true
        }

        save()
        exchangeMijnTeamData()
        
    }
    

    
 
    
}
