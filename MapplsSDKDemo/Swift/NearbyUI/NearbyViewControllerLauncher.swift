import UIKit
import MapplsNearbyUI
import MapplsAPIKit
import MapplsMap

class NearbyViewControllerLauncher: UIViewController {
    var button = UIButton()
    var pod : MapplsPodType = .none
    var radius: Int = 1000
    var orderby: MapplsSortByOrderType = .ascending
    var searchby: MapplsSearchByType = .distance
    var refLocation : String? = nil
    var bound: MapplsRectangularRegion!
    var deeplink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let settingsBarButton = UIBarButtonItem(title: "Filter Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.rightBarButtonItems = [settingsBarButton]
        setupButtonLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let deeplink = deeplink {
            var category : MapplsNearbyCategories?
            
            switch deeplink {
            case "atm":
                category = MapplsNearbyCategories(title: "ATM",
                                                  selectedImage: UIImage(systemName: "creditcard.fill")!,
                                                  unselectedImage: UIImage(systemName: "creditcard")!,
                                                  isSelected: true,
                                                  categoryKeywords: ["FODCOF"],
                                                        mapNearbyCategoryIcon: UIImage(systemName: "creditcard.fill")!)
            case "pubsandbars":
                category = MapplsNearbyCategories(title: "Pubs and bars",
                                                  selectedImage: UIImage(named: "cocktail")!,
                                                  unselectedImage: UIImage(named: "cocktail")!,
                                                    isSelected: true,
                                                    categoryKeywords: ["FODCOF"],
                                                  mapNearbyCategoryIcon: UIImage(named: "cocktail")!.imageWith(newSize: .init(width: 25, height: 25)))
            case "parking":
                category = MapplsNearbyCategories(title: "Parking",
                                                            selectedImage: UIImage(systemName: "parkingsign")!,
                                                            unselectedImage: UIImage(systemName: "parkingsign")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "parkingsign")!)
            case "hotels":
                category = MapplsNearbyCategories(title: "Hotels",
                                                            selectedImage: UIImage(systemName: "bed.double.fill")!,
                                                            unselectedImage: UIImage(systemName: "bed.double")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "bed.double.fill")!)
            case "coffee":
                category = MapplsNearbyCategories(title: "Coffee",
                                                            selectedImage: UIImage(systemName: "cup.and.saucer.fill")!,
                                                            unselectedImage: UIImage(systemName: "cup.and.saucer")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "cup.and.saucer.fill")!)
            case "restaurants":
                category = MapplsNearbyCategories(title: "Restaurants",
                                                            selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                                            unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
            case "pharmacy":
                category = MapplsNearbyCategories(title: "Pharmacy",
                                                            selectedImage: UIImage(systemName: "bandage.fill")!,
                                                            unselectedImage: UIImage(systemName: "bandage")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "bandage.fill")! )
            case "transport":
                category = MapplsNearbyCategories(title: "Transport",
                                                            selectedImage: UIImage(systemName: "bus.fill")!,
                                                            unselectedImage: UIImage(systemName: "bus")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                  mapNearbyCategoryIcon: UIImage(systemName: "bus.fill")!)
            case "hospitals":
                category = MapplsNearbyCategories(title: "Hospitals",
                                                  selectedImage: UIImage(systemName: "bolt.heart.fill")!,
                                                            unselectedImage: UIImage(systemName: "bolt.heart")!,
                                                            isSelected: true,
                                                            categoryKeywords: ["FODCOF"],
                                                            mapNearbyCategoryIcon: UIImage(systemName: "bolt.heart.fill")!)
            default:
                break
            }
            
            let nearbyUI = MapplsNearbyCategoriesViewController()
            
            var  nearbyCategories = [MapplsNearbyCategories]()


            if let coffeeCategory = category {
                nearbyCategories.append(coffeeCategory)
            }
            
            nearbyUI.nearbyCategories = nearbyCategories

            self.navigationController?.pushViewController(nearbyUI, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deeplink = nil
    }
    
    func setupButtonLayout() {
        button.backgroundColor = .brown
        self.view.addSubview(button)
        button.setTitle("launch nearby VC", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(launchNearby), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 300).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    func converToCoordinate(location: String) -> CLLocationCoordinate2D? {
        let locationString = location.split(separator: ",")
        if locationString.count < 2 {
            return nil
        } else if locationString.count == 2 {
            let latitude: Double = Double(locationString.first!) ?? 0.0
            let longitue: Double = Double(locationString.last!) ?? 0.0
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitue))
            print("coordinate: \(latitude), \(longitue)")
            return coordinate
        } else {
            return nil
        }
    }
    @objc func settingsButtonTapped() {
        let vc = NearbyFilterConfigurationSetting()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @objc func launchNearby() {
        let vc = MapplsNearbyCategoriesViewController()
        
        let configuration = MapplsNearbyConfiguration()
        configuration.nearbyFilterConfiguration = getFilterValue()
        vc.nearbyConfiguration = configuration
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func getFilterValue() -> MapplsNearbyFilterConfiguration {
      
        let configuration = MapplsNearbyConfiguration()
        let filter = configuration.nearbyFilterConfiguration
        
        filter.radius = radius
        filter.pod = pod
        filter.searchBy = searchby
        filter.sortBy = MapplsSortByDistanceWithOrder(orderBy: orderby)
        if refLocation != nil && refLocation != "" {
            filter.refLocation = refLocation
        }
        if bound != nil {
            filter.bounds = bound
        }
        filter.bounds = bound
        return filter
        
    }
}
extension NearbyViewControllerLauncher: NearbyFilterConfigurationSettingDelegate {
    
    
    func nearbyFilterConfiguration(radius: String, refLocation: String, pod: MapplsPodType, orderby: MapplsSortByOrderType, searchby: MapplsSearchByType, bound:[String] ) {
        self.pod = pod
        self.orderby = orderby
        self.radius = Int(radius) ?? 1000
        self.searchby = searchby
        self.refLocation = refLocation
        var bottomRight: CLLocationCoordinate2D!
        var topLeft: CLLocationCoordinate2D!
        if let topRightStringCoordinate = bound.first, let topLeftStringCoordinate = bound.last {
            topLeft = converToCoordinate(location: topRightStringCoordinate)
            bottomRight = converToCoordinate(location: topLeftStringCoordinate)
            if let topLeft = topLeft ,let bottomRight = bottomRight {
                let b = MapplsRectangularRegion(topLeft: topLeft, bottomRight: bottomRight)
                self.bound = b
            }
        }
    }
}
extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return image.withRenderingMode(renderingMode)
    }
}
