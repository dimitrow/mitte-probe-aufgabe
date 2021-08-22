//
//  ViewController.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        if let url = RiverLisAPI.baseURL {
            
            RiverListFetchService().fetchRiverList(endPoint: url, type: RiverModel.self) { result in
                
                print(result)
                
            }
        }
    }
}

