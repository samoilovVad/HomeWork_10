//
//  ViewController.swift
//  HomeWork_10
//
//  Created by Vadim Samoilov on 23.10.22.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var volumeLevel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var sliderVolume: UISlider!
    @IBOutlet private var volumeTextField: UITextField!
    @IBOutlet private var timePicker: UIDatePicker!
    @IBOutlet private var settingTime: UIButton!
    @IBOutlet private var alarmSwitcher: UISwitch!
    @IBOutlet private var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClearButton()
        setupSettingTimeButton()
        setupVolumeSlider()
        setupProgressView()
    }

    @IBAction func clearButtonAction(_ sender: Any) {
        settingTime.setTitle("", for: .normal)
        alarmSwitcher.setOn(false, animated: true)
        setupSettingTimeButton()
    }


    @IBAction func setTimeButton(_ sender: Any) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let time = format.string(from: timePicker.date)
        settingTime.setTitle("\(time)", for: .normal)
    }
    
    @IBAction func setVolume(_ sender: Any) {
        progressView.progress = sliderVolume.value
        volumeTextField.text = String(format: "%.1f", sliderVolume.value)
    }
    
    func setupSettingTimeButton() {
        settingTime.isUserInteractionEnabled = false
        if alarmSwitcher.isOn {
            settingTime.titleLabel?.textColor = .white
            settingTime.isEnabled = true
        } else {
            settingTime.titleLabel?.textColor = .gray
            settingTime.isEnabled = false
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            settingTime.titleLabel?.textColor = .white
            settingTime.isEnabled = true
        } else {
            settingTime.titleLabel?.textColor = .gray
            settingTime.isEnabled = false
        }
        setupClearButton()
    }
    
    func setupClearButton() {
        clearButton.isEnabled = alarmSwitcher.isOn
    }
    
    func setupVolumeSlider() {
        sliderVolume.thumbTintColor = .red
        sliderVolume.tintColor = .lightGray
    }
    
    func setupProgressView() {
        progressView.tintColor = .red
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
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
