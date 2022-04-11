//
//  LocationSearchViewController.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-09.
//

import UIKit

class LocationSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var service: LocationSearchService?
    var items: [LocationViewModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        loadData()
    }
    
    func setUpUI() {
        title = "Select location"
        tableView.register(UINib(nibName:LocationTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: LocationTableViewCell.reuseID)
        tableView.setSeparatorSpaceToZero()
    }
    
    func loadData() {
        Task {
            do {
                items  = try await service?.loadLocations() ?? []
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.select()
        navigationController?.popViewController(animated: true)
    }
}

extension LocationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseID, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configureCell(with: item)

        return cell
    }
}
