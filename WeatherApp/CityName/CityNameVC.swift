//
//  CityNameVC.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

protocol CityNameProtocol {
    
    func setCity(city: String)
}


class CityNameVC: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var goBtn: UIButton!
    
    var cityName: String?
    
    var delegate: CityNameProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    private func setTheme(){
        self.view.backgroundColor = Color.Light_Gray.value
        goBtn.setTitle("Proceed", for: .normal)
        AppTheme.applyThemeBoldFont(to: [goBtn], size: 18.0)
        
        goBtn.backgroundColor = Color.BackgroundLightBlue.value
        goBtn.setTitleColor(Color.White.value, for: .normal)
        goBtn.layer.cornerRadius = 8
        goBtn.layer.borderColor = Color.White.value.cgColor
        goBtn.layer.borderWidth = 1.0
        
        AppTheme.applyThemeRegularFont(to: [cityTextField], size: 18.0)
        cityTextField.delegate = self
        
    }
    
    func setData(){
        if let cityName = cityName {
            cityTextField.text = cityName
        }
    }

    @IBAction func btnAction(_ sender: UIButton) {
        
        goBtnAction()
    
    }
    
    func goBtnAction() {
        guard let cityName = cityTextField.text,
            cityName.count > 0 else {
                return
        }
        
        let showWeatherScreen = UserDefaults.standard.bool(forKey: Constant.USER_DEFAUL_KEY) ?? false
        
        if showWeatherScreen {
            if let delegate = delegate {
                delegate.setCity(city: cityName)
            }
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let vc = AppNavigationCordinator.shared.createWeatherDetailsModule(city: cityName)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
extension CityNameVC : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        goBtnAction()
        return true
    }
    
}
