//
//  ResultViewController.swift
//  Mad Lips
//
//  Created by Fried on 19/11/2018.
//  Copyright © 2018 Fried. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var story: Story!
    @IBOutlet weak var storyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        storyLabel.text = story.normalText
    }
}
