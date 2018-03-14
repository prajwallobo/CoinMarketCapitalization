//
//  CoinListViewController.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 12/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import UIKit

struct CoinListViewControllerConstants{
    static let kRowHeight : CGFloat = 98.0
    static let kPageSize : Int = 50

}

class CoinListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    private var coinList = [Coin]()
    private var datasource = [Coin]()
    private var refreshControl = UIRefreshControl()
    var pageIndex : Int = 0
    var isLastPage = false
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coin Market Cap"
        getCoins()
        registerCell()
        setupTableView()
        startTimer()
        


    }
    func startTimer(){
        //Timer
        timer = Timer(timeInterval: 60, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes) //To avoid runloop entering trackingMode on tableView scroll.
    }
    
    func setupTableView(){
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor.navBar
        let attribute = [NSAttributedStringKey.foregroundColor: UIColor.navBar, NSAttributedStringKey.font: UIFont(name: "KohinoorDevanagari-Medium", size: 16.0)!]
        refreshControl.attributedTitle = NSAttributedString(string: "Rereshing Latest Changes", attributes: attribute)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()

    }
    
    //MARK:- Helper
    func registerCell(){
        tableView.register(CryptoCoinTableViewCell.cellNib(), forCellReuseIdentifier: "CryptoCoinTableViewCell")
        tableView.register(CoinLoadMoreTableViewCell.cellNib(), forCellReuseIdentifier: "CoinLoadMoreTableViewCell")
    }
    
    //MARK:- Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = datasource.count
        if !isLastPage && rows != 0 {
            rows = rows + 1
        }
        return rows
    }

    //MARK:- Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == datasource.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoinLoadMoreTableViewCell", for: indexPath) as! CoinLoadMoreTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCoinTableViewCell", for: indexPath) as! CryptoCoinTableViewCell
            cell.selectionStyle = .none
            let coin = datasource[indexPath.row]
            cell.coin = coin
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CoinListViewControllerConstants.kRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let aCell = cell as? CoinLoadMoreTableViewCell else {return}
        aCell.activityIndicator.startAnimating()
        loadMoreCoins()
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let aCell = cell as? CoinLoadMoreTableViewCell  else {
            return
        }
        aCell.activityIndicator.stopAnimating()
    }
    
    
    @objc func getCoins(){
        
        let pageIndex = self.pageIndex
        let pageSize = CoinListViewControllerConstants.kPageSize
        var datasourceArray = coinList
        
        if pageIndex == 0{
            showHUD(with: "Fetching Coins")
        }else if refreshControl.isRefreshing{
            showHUD()
        }
                                        //Hardcoded to INR
        APIService.shared.getCryptoWith(currency: "INR", start : pageIndex, limit: pageSize) {[weak self] (coin, error) in
            guard let ref = self else {return}
            
            if let error = error{
                ref.dismissHUD()
                if let message = error.message{
                    print("Error occured : \(message)")
                }
            }else{
                if ref.pageIndex == 0 {
                    ref.showSuccess(with: "Coins Fetched")
                }
                if let coin =  coin{
                    if coin.count < CoinListViewControllerConstants.kPageSize{
                        ref.isLastPage = true //Know if there are no more coins to load
                    }
                    
                    datasourceArray.append(contentsOf: coin)
                    
                    if datasourceArray.count == coin.count{ //Fetching for the first time
                        UIView.transition(with: ref.tableView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                            ref.coinList = datasourceArray
                            ref.datasource = ref.coinList
                            ref.tableView.reloadData()
                        }, completion: nil)
                    }else{ //Load more coins 
                        if ref.isLastPage{
                            ref.tableView.reloadData()
                        }else{
                            //Insert newly fetched coins into tableView
                            var indexPathArray = [IndexPath]()
                            for (_, element) in coin.enumerated(){
                                if let elementIndex =  datasourceArray.index(of: element){
                                    let indexPath = IndexPath(item: elementIndex, section: 0)
                                    indexPathArray.append(indexPath)
                                }
                            }
                            ref.coinList = datasourceArray
                            ref.datasource = ref.coinList //Maintaining separate array to clear array when pull to refresh done
                            ref.tableView.beginUpdates()
                                ref.tableView.insertRows(at: indexPathArray, with: .fade)
                            ref.tableView.endUpdates()
                         
                        }
                    }
                    if ref.refreshControl.isRefreshing{
                        ref.refreshControl.endRefreshing()
                        ref.dismissHUD()
                    }
                }
            }
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if timer.isValid{ //Cancelling the auto refresh when user scrolls
            timer.invalidate()
            startTimer()
        }
    }
    
    @objc func refreshData(){
        pageIndex = 0
        if coinList.count > 0{
            coinList.removeAll(keepingCapacity: false)
        }
        getCoins()
    }
    
    func loadMoreCoins(){
        pageIndex = pageIndex + CoinListViewControllerConstants.kPageSize
        getCoins()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
