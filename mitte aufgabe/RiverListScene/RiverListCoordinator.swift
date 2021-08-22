//
//  RiverListCoordinator.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import UIKit

class RiverListCoordinator {

    func initScene() -> RiverListViewController {
        
        let viewController = RiverListViewController()
        let viewModel = RiverListViewModel(view: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
