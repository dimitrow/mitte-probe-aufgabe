//
//  RiverListDataSource.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 23.08.21.
//

import UIKit

extension RiverListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.riverList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let river = viewModel?.riverList[indexPath.row] {
            
        }
        
        return UITableViewCell()
    }
}
