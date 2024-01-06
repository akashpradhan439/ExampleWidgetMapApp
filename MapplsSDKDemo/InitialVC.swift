//
//  InitialVC.swift

//
//  Created by CE Info on 27/07/18.
//  Copyright © 2022 Mappls. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation
import WidgetKit

class InitialVC: UIViewController {

    var deeplink: String?
    let locManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.requestWhenInUseAuthorization()

        if #available(iOS 14.0, *) {
            if locManager.authorizationStatus == .authorizedAlways ||
                locManager.authorizationStatus == .authorizedWhenInUse {
                if let coordinate = locManager.location?.coordinate {
                    currentLocationSnapshot(coordinate: coordinate, completion: {image in
                        if let image = image {
                            self.setImageForWidget(image: image)
                        }
                    })
                }
            }
        } else {
            if CLLocationManager.authorizationStatus() == .authorizedAlways ||
                CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                if let coordinate = locManager.location?.coordinate {
                    currentLocationSnapshot(coordinate: coordinate, completion: {image in
                        if let image = image {
                            self.setImageForWidget(image: image)
                        }
                    })
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        deeplinkHandler(deeplink: deeplink)
    }

    func currentLocationSnapshot(coordinate: CLLocationCoordinate2D, completion: @escaping (UIImage?) -> ()) {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: CLLocationDistance(2),
                                            longitudinalMeters: CLLocationDistance(2))
        options.size = self.view.frame.size
        options.scale = UIScreen.main.scale
        options.mapType = .satellite
        options.pointOfInterestFilter = .includingAll

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(with: DispatchQueue(label: "ForSnapshot"), completionHandler: {snapshot, error in
            if let snapshotImage = snapshot?.image {
                completion(snapshotImage)
            } else {
                completion(nil)
            }
        })
    }

    func setImageForWidget(image: UIImage){
        let sharedContainer = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.Mappls.MapplsSDKDemo.DemoWidget")
        let fileURL = sharedContainer?.appendingPathComponent("widgetImage.png")

        if let fileURL = fileURL {
            do {
                try image.pngData()?.write(to: fileURL)
                UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.synchronize()
            } catch {
                print("Error writing image data to file: \(error)")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        deeplink = nil
    }
    
    func deeplinkHandler(deeplink: String?){
        if let deeplink = deeplink {
            let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC
            vctrl?.deeplink = deeplink
            self.navigationController?.pushViewController(vctrl!, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: -  Button Method
    @IBAction func objectiveC(_ sender: Any) {
        let vctrl = UIStoryboard(name: "MainC", bundle: nil).instantiateViewController(withIdentifier: "ListVCOC") as? ListVCOC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @IBAction func swift(_ sender: Any) {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @IBAction func swiftUI(_ sender: Any) {
        let vctrl = UIHostingController(rootView: SampleLauncherSwiftUIListView())
        self.navigationController?.pushViewController(vctrl, animated: true)
    }
}
