//
//  ViewController.swift
//  Project16
//
//  Created by nikita on 16.02.2023.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    let mapTypes = ["Satellite": MKMapType.satellite, "Standard muted": MKMapType.mutedStandard, "Standard": MKMapType.standard]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(mapStyle))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", url: "https://en.wikipedia.org/wiki/London")
                 let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", url: "https://en.wikipedia.org/wiki/Oslo")
                 let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", url: "https://en.wikipedia.org/wiki/Paris")
                 let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", url: "https://en.wikipedia.org/wiki/Rome")
                 let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", url: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }

            let identifier = "Capital"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView


                 if annotationView == nil {
                     annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)

                     annotationView?.markerTintColor = .blue
                     annotationView?.canShowCallout = true

                     let btn = UIButton(type: .detailDisclosure)
                     annotationView?.rightCalloutAccessoryView = btn
                 } else {
                     annotationView?.markerTintColor = .blue
                     annotationView?.annotation = annotation
                 }
                 return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        let url = capital.url
        

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Wiki", style: .default, handler: { [weak self] _ in
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                        vc.url = url
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }))
        
        present(ac, animated: true)
    }
    
    @objc func mapStyle() {
        let ac = UIAlertController(title: "What style of the map do you prefer?", message: nil, preferredStyle: .actionSheet)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                 for mapType in mapTypes.keys {
                     ac.addAction(UIAlertAction(title: mapType, style: .default, handler: choosedMap))
                 }
                 ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                 present(ac, animated: true)
        
    }
   
    func choosedMap(action: UIAlertAction) {
            guard let title = action.title else { return }
            guard let currentMap = mapTypes[title] else { return }
            mapView.mapType = currentMap

        }
}

