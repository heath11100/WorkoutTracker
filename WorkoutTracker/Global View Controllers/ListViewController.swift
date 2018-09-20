//
//  ListViewController.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionViewLayout:UICollectionViewFlowLayout
    private let collectionView:UICollectionView
    
    private let rowID = "ListCell"
    private let headerID = "HeaderCell"
    
    private var flatData:[NamedElement] = []
    private(set) var sectionTitles:[String] = []
    private(set) var rowData:[[NamedElement]] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var newElementText:String { return "New Element" }
    
    init() {
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: self.collectionViewLayout)
        
        super.init(nibName: nil, bundle: nil)
        
        self.collectionViewLayout.minimumLineSpacing = 0
        self.collectionViewLayout.minimumInteritemSpacing = 0
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewLayout.itemSize = CGSize(width: 60, height: 60)
        self.collectionViewLayout.headerReferenceSize = CGSize(width: 300, height: 60)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: self.rowID)
        self.collectionView.register(ListCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = Style.backgroundColor
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.collectionView)
        
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: guide.rightAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Elements"
        
        setupNavigationBar()
        setupToolbar()
        styleSearchBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.searchController = self.searchController
    }
    
    private func setupToolbar() {
        self.toolbarItems = UIToolbar.getItems(withButtonText: self.newElementText, target: self, action: #selector(createNewElement))
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    private func styleSearchBar() {
        let searchBar = self.searchController.searchBar
        searchBar.tintColor = Style.backgroundColor
        searchBar.barTintColor = Style.backgroundColor
        searchBar.setTextFieldColor(color: Style.textColor)
        searchBar.setTextColor(color: Style.textColor)
        searchBar.setBackgroundColor(color: Style.backgroundColor)
    }
    
    /** Called when a user taps the "New Element" button */
    @objc func createNewElement() { }
    
    func load(namedElements:[NamedElement]) {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let sortedElements = namedElements.sorted(by: { e1, e2 in return e1.name < e2.name })
        
        var titles = [String]()
        var data = [[NamedElement]]()
        
        let otherTitle = "Other"
        var otherData = [NamedElement]()
        
        var prevChar:Character? = nil
        for element in sortedElements {
            if let char = element.name.lowercased().first {
                if letters.contains(char) {
                    if char != prevChar { //New letter
                        titles.append(String(char).uppercased())
                        data.append([])
                        prevChar = char
                    }
                    data[data.endIndex - 1].append(element)
                    
                } else {
                    otherData.append(element)
                }
            }
        }
        
        if !otherData.isEmpty {
            titles.append(otherTitle)
            data.append(otherData)
        }
        
        self.sectionTitles = titles
        self.rowData = data
    }
}

extension ListViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerID, for: indexPath) as! ListCollectionHeaderView
        header.titleLabel.text = self.sectionTitles[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.rowID, for: indexPath) as! ListCollectionViewCell
        cell.titleLabel.text = self.rowData[indexPath.section][indexPath.row].name
        return cell
    }
}

extension ListViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: Highlighting
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = Style.backgroundColor
    }
}

extension ListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmed = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
        guard trimmed != "" else {
            load(namedElements: self.flatData)
            self.collectionView.reloadData()
            return
        }

        let filteredElements = self.flatData.filter({ element in
            return element.name.lowercased().contains(trimmed)
        })
        load(namedElements: filteredElements)
        self.collectionView.reloadData()
    }
}

extension ListViewController:UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.flatData = self.rowData.flatMap({ $0 })
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        load(namedElements: self.flatData)
    }
}
