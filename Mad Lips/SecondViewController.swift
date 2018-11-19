//
//  SecondViewController.swift
//  Mad Lips
//
//  Created by Fried on 19/11/2018.
//  Copyright © 2018 Fried. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var storyString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(storyString)


        // search for path to file and get text in that file
        let storyPath = Bundle.main.path(forResource: storyString, ofType: "txt")
        let text = try! String(contentsOfFile: storyPath!, encoding: .utf8)
        
        // create story
        let story = Story(withText: text)

        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
