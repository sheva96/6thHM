//
//  ColorSettingViewController.swift
//  6thHM
//
//  Created by Евгений Шевченко on 30.10.2020.
//

import UIKit

class ColorSettingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var rgbView: UIView!
    
    @IBOutlet weak var redColorLabel: UILabel!
    @IBOutlet weak var greenColorLabel: UILabel!
    @IBOutlet weak var blueColorLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    
    var color: UIColor!
    
    var delegate: ColorSettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
        rgbView.backgroundColor = color
        
        setStartValues()
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        
        redColorTextField.backgroundColor = .white
        greenColorTextField.backgroundColor = .white
        blueColorTextField.backgroundColor = .white
    }
    
    // MARK: - End editing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Slider action
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redColorLabel.text = getSliderTextValue(sender)
            redColorTextField.text = redColorLabel.text
        case 1:
            greenColorLabel.text = getSliderTextValue(sender)
            greenColorTextField.text = greenColorLabel.text
        case 2:
            blueColorLabel.text = getSliderTextValue(sender)
            blueColorTextField.text = blueColorLabel.text
        default:
            break
        }
        setColor()
    }
    
    // MARK: Done button Action
    @IBAction func doneButtonAction() {
        guard let color = rgbView.backgroundColor else { return }
        delegate.getColor(color)
        dismiss(animated: true)
    }
    
    // MARK: - Set color for rgb view
    private func setColor() {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    // MARK: - Get slider text value
    private func getSliderTextValue(_ sender: UISlider) -> String {
        String(format: "%.2f", sender.value)
    }
    
    // MARK: - Get text value
    private func getTextValue(_ sender: Float) -> String {
        String(format: "%.2f", sender)
    }
    
    // MARK: - Set start values
    private func setStartValues() {
        
        let red = Float(color.rgba.red)
        let green = Float(color.rgba.green)
        let blue = Float(color.rgba.blue)
        
        redColorSlider.value = red
        greenColorSlider.value = green
        blueColorSlider.value = blue
        
        redColorLabel.text = getTextValue(red)
        greenColorLabel.text = getTextValue(green)
        blueColorLabel.text = getTextValue(blue)
        
        redColorTextField.text = redColorLabel.text
        greenColorTextField.text = greenColorLabel.text
        blueColorTextField.text = blueColorLabel.text
    }
}

// MARK: - Text field delegate
extension ColorSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0: textField.resignFirstResponder()
        case 1: textField.resignFirstResponder()
        case 2: textField.resignFirstResponder()
        default: break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else { return }
        
        switch textField.tag {
        case 0:
            redColorLabel.text = text
            redColorSlider.value = value
        case 1:
            greenColorLabel.text = text
            greenColorSlider.value = value
        case 2:
            blueColorLabel.text = text
            blueColorSlider.value = value
        default:
            break
        }
        setColor()
    }
}
