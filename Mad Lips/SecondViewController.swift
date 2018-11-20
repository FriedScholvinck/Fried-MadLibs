//
//  SecondViewController.swift
//  Mad Lips
//
//  Created by Fried on 19/11/2018.
//  Copyright © 2018 Fried. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // variables needed
    var storyString: String!
    var titleName: String!
    var story: Story!
    var progress: Float = 0
    
    // create oulets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var OKbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change navigation title and OK button
        self.navigationItem.title = titleName
        OKbutton.applyDesign()
        
        // search for path to file and get text in that file
        let storyPath = Bundle.main.path(forResource: storyString, ofType: "txt")
        let text = try! String(contentsOfFile: storyPath!, encoding: .utf8)
        
        // create story
        story = Story(withText: text)
        
        instructionLabel.text = "Type a \(story.nextPlaceholder!)"
//        textField.placeholder = story.nextPlaceholder
        progressView.setProgress(progress, animated: true)
        
        // Do any additional setup after loading the view.
    }
    

    ///
    @IBAction func okButtonTapped(_ sender: UIButton) {
        
        let word = textField.text
        story.fillInPlaceholder(word: word!)
        
        if story.isFilledIn {
            
//            // hide keyboard
//            textField.resignFirstResponder()
//
//            instructionLabel.text = "You finished your story!"
//
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        else {
            nextWord()
        }
    }
    
    ///
    func nextWord() {
        
        // empty text field for new word
        textField.text = ""
        
        instructionLabel.text = "Type a \(story.nextPlaceholder!)"
        //        textField.placeholder = story.nextPlaceholder
        
        progress = Float(story.totalPlaceholders - story.remainingPlaceholders) / Float( story.totalPlaceholders)
        progressView.setProgress(progress, animated: true)
        
    }
    
    /// pass variable around in app
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? ResultViewController {
            next.story = story
        }
        
    }
    
}
