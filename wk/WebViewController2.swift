//
//  ViewController.swift
//  WK
//
//  Created by Apple on 23/03/2021.
//
import class Foundation.NSString
import UIKit
import WebKit



class ErrorViewController: UIViewController {
  
    @IBOutlet weak var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func actionCalled(_ sender: UIButton) {
        print("you son of the bitch im in")
        if let url = URL(string: "https://www.facebook.com/business/small-business") {
            UIApplication.shared.open(url)
        }
    }
    
   

}

