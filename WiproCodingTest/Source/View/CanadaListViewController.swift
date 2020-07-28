//
//  CanadaListViewController.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class CanadaListViewController: UITableViewController {
    //cell reuse Identifier
    let cellIdentifier = "canadaCellId"
    var canadaInfoList = [Rows]()
    var canadaViewModel = CanadaViewModel()
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCanadaListTableView()
        self.loadCanadaData()
    }
    //MARK:- set up Navigation bar
    func setupNavigationBar() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: helveticaNeueMedium, size: (UIDevice.current.userInterfaceIdiom == .pad) ? 30 : 18)!,.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.barTintColor = appThemeColor()
        self.title = "About Canada"
    }
    //MARK:- set up UITableView
    func setupCanadaListTableView() {
        let refreshControl = UIRefreshControl()
        tableView.register(CanadaListCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = appThemeColor()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
    }
    //MARK:- Load Canada Data
    fileprivate func loadCanadaData(){
        canadaViewModel.fetchCanadaData()
        canadaViewModel.reloadDataCompletionBlock = { [weak self] in
            self!.canadaInfoList = (self!.canadaViewModel.canadaData?.rows)!
            DispatchQueue.main.async {
                self!.title = (self!.canadaViewModel.canadaData?.title != nil) ? self!.canadaViewModel.canadaData?.title : "Canada Details"
                self!.tableView.reloadData()
            }
        }
    }
    //MARK:- UITableView Delegate And Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (canadaInfoList.count)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CanadaListCell
        let canadaViewModel = canadaInfoList[indexPath.row]
        cell.canadaEachRowData = canadaViewModel
        return cell
    }
    //MARK:- Refresh Table Data
    @objc func refreshTableData(sender: UIRefreshControl)
    {
        loadCanadaData()
        sender.endRefreshing()
    }
    
}
