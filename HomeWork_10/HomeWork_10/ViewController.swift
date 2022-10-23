//
//  ViewController.swift
//  HomeWork_10
//
//  Created by Vadim Samoilov on 23.10.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var volumeLevel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var volumeTextField: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var settingTime: UIButton!
    
    @IBOutlet weak var alarmSwitcher: UISwitch!
    
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func clearButtonAction(_ sender: Any) {
    }
    @IBAction func isAlarmOn(_ sender: Any) {
    }
    @IBAction func setTimeButton(_ sender: Any) {
    }
    
    @IBAction func setVolume(_ sender: Any) {
        progressView.progress = sliderVolume.value
        volumeTextField.text = String(format: "%.1f", sliderVolume.value)
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if let currentValue = Float(text), currentValue >= 0, currentValue <= 1 {
            sliderVolume.value = currentValue
            progressView.progress = currentValue
        } else {
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
            let alert = UIAlertController(title: "Error", message: "Need set value from 0 to 1", preferredStyle: .alert)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            textField.text = ""
        }
        
    }
}

