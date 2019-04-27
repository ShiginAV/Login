//
//  ResultViewController.swift
//  Login
//
//  Created by Alexander on 25/04/2019.
//  Copyright © 2019 Alexander Shigin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var labelText: String? {
        didSet {
            resultLabel.text = labelText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
