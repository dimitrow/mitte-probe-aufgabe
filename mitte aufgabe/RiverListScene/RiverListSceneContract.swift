//
//  RiverListSceneContract.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

enum MeasureUnit: String {
    case kilometers = "Kilometers"
    case miles = "Miles"
}

protocol RiverListViewDelegate: AnyObject {
    
    func updateContent()
    func operationfailed(_ error: Error)
}

protocol RiverListViewModelProtocol: AnyObject {
    
    var riverListModel: RiverListModel { get set }
    
    func fetchRivers()
    func filterApply(_ filter: MeasureUnit)
}
