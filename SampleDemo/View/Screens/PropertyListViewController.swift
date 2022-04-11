//
//  ViewController.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-06.
//

import UIKit
import CoreLocation

protocol PropertiesService {
    func loadProperties() async throws -> [PropertyListViewModel]
}

class PropertyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    
    var service: PropertiesService?
    var items: [PropertyListViewModel] = []
    var originalItems: [PropertyListViewModel] = []
    var selectedLocation: CLPlacemark?
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.navigationBar.isHidden = false
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentLocation()

        setUpUI()
        loadData()
    }
    
    func setUpUI() {
        tableView.register(UINib(nibName:PropertyListTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: PropertyListTableViewCell.reuseID)
    }
    
    func loadData() {
        Task {
            do {
                originalItems  = try await service?.loadProperties() ?? []
                items = originalItems
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
}

//MARK :- Actions
extension PropertyListViewController {
    func locationSelected(placemark: CLPlacemark?) {
       selectedLocation = placemark
    
        items = originalItems.filter { $0.placemark?.locality == placemark?.locality &&
            $0.placemark?.administrativeArea == placemark?.administrativeArea &&  $0.placemark?.country == placemark?.country }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        if let locationSearchVC = storyboard?.instantiateViewController(withIdentifier: "LocationSearchViewController") as? LocationListViewController {
            locationSearchVC.service = LocationListService(networkSession: FakeNetworkSession.shared, currentLocation: currentLocation, select: { [weak self] location in
                self?.locationSelected(placemark: location)
            })
            show(locationSearchVC, sender: self)
        }
    }
    
    func showDetails(property: Property) {
        //Show details when user tapped on property
    }
    
    func addToFavorite(property: Property) {
        //Add a property to favorites
    }
}

extension PropertyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyListTableViewCell.reuseID, for: indexPath) as? PropertyListTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configureCell(with: item)

        return cell
    }
}

extension PropertyListViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            currentLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
}
