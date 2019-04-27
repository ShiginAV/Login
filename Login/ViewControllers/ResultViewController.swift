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
    var resultLabelTextString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = resultLabelTextString
    }
}

//MARK: - Actions
extension ResultViewController {
    @IBAction func actionCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
