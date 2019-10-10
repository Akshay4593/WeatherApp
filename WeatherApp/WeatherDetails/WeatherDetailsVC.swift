//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class WeatherDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: WeatherDetailsPresenterProtocol?
    
    private var currentDayData: WeatherResponse?
    private var weekDataList: [WeatherResponse] = []
    
    var refreshControl = UIRefreshControl()
    
    private var dailyData: DailyData?
    private var weeklyData: [WeeklyData] = []
    private var dataType: WheatherDetailsFor = .showingOfflineData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setUI(){
        tableView.register(UINib(nibName: "ForecastTVCell", bundle: nil), forCellReuseIdentifier: "ForecastTVCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 280
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        self.navigationItem.hidesBackButton = true
        title = "Weather Report"
        
        self.view.backgroundColor = Color.BackgroundLightBlue.value
        tableView.backgroundColor = Color.BackgroundLightBlue.value
        
    }
    
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        presenter?.viewWillAppear()
    }
    
    private func reloadData(){
        refreshControl.endRefreshing()
        tableView.reloadData()
        
    }
}

extension WeatherDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataType {
        default:
            if weeklyData.count > 0 || weekDataList.count > 0 {
                return 1
            } else {
                return 0
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTVCell", for: indexPath) as! ForecastTVCell
        switch dataType {
        case .showingOfflineData:
            cell.showingDataFor = .showingOfflineData
            cell.configureCell(weeklyData: weeklyData)
            break
            
        case .showingApiData:
            cell.showingDataFor = .showingApiData
            cell.configureCell(data: weekDataList)
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let sectionView = (Bundle.main.loadNibNamed("CurrentDayTVSection", owner: self, options: nil)![0] as? CurrentDayTVSection)
        sectionView?.delegate = self
        
        switch dataType {
        case .showingOfflineData:
            if let dailyData = self.dailyData {
                sectionView?.configureSection(dailyData: dailyData)
            }
            break
            
        case .showingApiData:
            if let currentDayData = self.currentDayData {
                sectionView?.configureSection(currentDayData: currentDayData)
            }
            break
        }
        return sectionView
    }
    
    
}
extension WeatherDetailsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
}

extension WeatherDetailsVC : WeatherDetailsVCProtocol {
    func showLoading() {
        showSpinner(onView: self.view)
        refreshControl.endRefreshing()

    }
    
    func hideLoading() {
        removeSpinner()
        refreshControl.endRefreshing()

    }
    
    
    func makeToast(msg: String) {
        show(message: msg)
    }
    
    
    func showDailyData(dailyData: DailyData) {
        self.dailyData = dailyData
        reloadData()
    }
    
    func showWeeklyData(weeklyData: [WeeklyData]) {
        self.weeklyData = weeklyData
        reloadData()
    }
    
    func showCurrentDayData(response: WeatherResponse) {
        self.currentDayData = response
    }
    
    func showForecastData(response: [WeatherResponse]) {
        self.weekDataList = response
    }
    
    func showDataType(type: WheatherDetailsFor) {
        dataType =  type
        reloadData()
    }
    
}
extension WeatherDetailsVC : CurrentDayTVSectionDelegate {
    
    func goBtnTapped(city: String) {
        presenter?.showCityNameScreen(city: city, delegate: self)
    }
    
}

extension WeatherDetailsVC : CityNameProtocol {
    
    func setCity(city: String) {
        presenter?.cityName = city
        presenter?.viewWillAppear()
        
    }
    
    
    
}
