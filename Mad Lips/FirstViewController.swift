//
//  ViewController.swift
//  Mad Lips
//
//  Created by Fried on 19/11/2018.
//  Copyright © 2018 Fried. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData: [String] = []
    var selectedRow = 0

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        welcomeLabel.applyDesign()
        startButton.applyDesign()
        
        picker.delegate = self
        picker.dataSource = self
        
        // fill picker with data
        pickerData = ["Simple", "Tarzan", "University", "Clothes", "Dance"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "FirstSegue", sender: nil)
    }
    
    /// pass variable around in app
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? UINavigationController,
        let secondViewController = next.topViewController as? SecondViewController {
            let storyString = "madlib\(selectedRow)_\(pickerData[selectedRow].lowercased())"
            secondViewController.storyString = storyString
            secondViewController.titleName = pickerData[selectedRow]
        }
        
    }
    
    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
        
    }
    
    
}



extension UIButton {
    func applyDesign() {
        self.backgroundColor = UIColor.darkGray
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
}

// create
extension UILabel {
    func applyDesign() {
        self.backgroundColor = UIColor.darkGray
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.textColor = UIColor.white
    }
}
