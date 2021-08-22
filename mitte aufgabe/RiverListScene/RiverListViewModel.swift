//
//  RiverListViewModel.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 23.08.21.
//

import UIKit

class RiverListViewModel: RiverListViewModelProtocol {
    
    weak var view: RiverListViewDelegate?
    var riverList: [RiverModel] = []
    
    private let dataProvider = DataProvider()
    
    init(view: RiverListViewDelegate) {
        
        self.view = view
    }
    
    func fetchRivers() {
        
        guard let url = RiverListAPI.baseURL else {
            
            self.view?.operationfailed(NetworkError.customDescriptionError("missed or invalid URL"))
            return
        }
        
        dataProvider.fetchData(endPoint: url, type: RiverModel.self) { [weak self] result in
            
            switch result {
            case .success(let rivers):
                self?.riverList = rivers
                self?.view?.updateContent()
                break
            case .failure(let error):
                self?.view?.operationfailed(error)
                break
            }
        }
    }
}



