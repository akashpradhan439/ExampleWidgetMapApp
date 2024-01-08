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
            var nearbyCategory : MapplsNearbyCategories!
            
            let nearbyUI = MapplsNearbyCategoriesViewController()
            
            var  nearbyCategories = [MapplsNearbyCategories]()
            guard let buttonsData = try? JSONDecoder().decode(ButtonsData.self, from: SharedWidgetClass.shared.primaryData) else {
                return
            }
            
            switch Int(deeplink) {
            case 1: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 2: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 3: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 4: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 5: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 6: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 7: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 8: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            case 9: nearbyCategory = buttonNameToCategory(buttonName: buttonsData.but1.keys.first!)
            default:
                break
            }
            
            nearbyCategories.append(nearbyCategory)
            
            nearbyUI.nearbyCategories = nearbyCategories

            self.navigationController?.pushViewController(nearbyUI, animated: true)
        }
    }
    
    
    func buttonNameToCategory(buttonName: String) -> MapplsNearbyCategories? {
        switch buttonName{
        case "hospital":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "coffee":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "hotel":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "bus":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "medicine":
            return  MapplsNearbyCategories(title: "Restaurants",
                                           selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                           unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                           isSelected: true,
                                           categoryKeywords: ["FODCOF"],
                                           mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "atm":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "parking":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "bar":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        case "restaurant":
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
        default:
            return MapplsNearbyCategories(title: "Restaurants",
                                          selectedImage: UIImage(systemName: "fork.knife.circle.fill")!,
                                          unselectedImage: UIImage(systemName: "fork.knife.circle")!,
                                          isSelected: true,
                                          categoryKeywords: ["FODCOF"],
                                          mapNearbyCategoryIcon: UIImage(systemName: "fork.knife.circle.fill")!)
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
