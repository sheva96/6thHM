//
//  StartViewController.swift
//  6thHM
//
//  Created by Евгений Шевченко on 30.10.2020.
//

import UIKit


protocol ColorSettingViewControllerDelegate {
    func getColor(_ color: UIColor)
}

class StartViewController: UIViewController, ColorSettingViewControllerDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorSettingVC = segue.destination as! ColorSettingViewController
        colorSettingVC.color = view.backgroundColor
        colorSettingVC.delegate = self
    }
    
    func getColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

