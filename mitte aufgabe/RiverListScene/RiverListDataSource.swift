//
//  RiverListDataSource.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 23.08.21.
//

import UIKit

extension RiverListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.riverListModel.riverList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let river = viewModel?.riverListModel.riverList[indexPath.row], let measureUnit = viewModel?.riverListModel.choosenFilter  {
            
            return RiverCellBuilder().buildCell(for: tableView, river: river, measureUnit: measureUnit)
        }
        
        return UITableViewCell()
    }
}
