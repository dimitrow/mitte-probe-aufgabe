//
//  RiverListViewController.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import UIKit
import MBProgressHUD

class RiverListViewController: UIViewController {

    let measureUnitSelectionControl: UISegmentedControl = {
        
        let control = UISegmentedControl(items: [MeasureUnit.kilometers.rawValue, MeasureUnit.miles.rawValue])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(handleUnitSelection(_ :)), for: .valueChanged)
        
        return control
    }()
    
    let riversTableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib.init(nibName: RiverCell.identifier, bundle: nil), forCellReuseIdentifier: RiverCell.identifier)
        return tableView
    }()
    
    var viewModel: RiverListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "world's longest rivers"
        self.view.addSubview(measureUnitSelectionControl)
        self.view.addSubview(riversTableView)
        
        riversTableView.dataSource = self
        
        self.view.backgroundColor = .white
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel?.fetchRivers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.pinSegmentedControl()
        self.pinTableView()
    }
    
    //MARK: - UISetup
    
    private func pinSegmentedControl() {
        
        measureUnitSelectionControl.translatesAutoresizingMaskIntoConstraints = false
        measureUnitSelectionControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        measureUnitSelectionControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22.0).isActive = true
        measureUnitSelectionControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22.0).isActive = true
        measureUnitSelectionControl.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func pinTableView() {
        
        riversTableView.translatesAutoresizingMaskIntoConstraints = false
        riversTableView.topAnchor.constraint(equalTo: measureUnitSelectionControl.bottomAnchor, constant: 20.0).isActive = true
        riversTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        riversTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        riversTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func handleUnitSelection(_ sender: UISegmentedControl) {
                
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel?.filterApply(.kilometers)
            break
        case 1:
            viewModel?.filterApply(.miles)
            break
        default:
            break
        }
    }
}

extension RiverListViewController: RiverListViewDelegate {
    
    func updateContent() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.riversTableView.reloadData()
            
            if let view = self?.view {
                
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    func operationfailed(_ error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(error.localizedDescription)
                 
            if let view = self?.view {
                
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    private func showAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            
            self?.viewModel?.fetchRivers()
        }
        
        alertController.addAction(retryAction)
        present(alertController, animated: true)
    }
}
