//
//  ViewController.swift
//  MapTest
//
//  Created by Mohamed Elkady on 3/21/16.
//  Copyright © 2016 Mohamed Elkady. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
	@IBOutlet weak var myMapView: MKMapView!

	let accessoryIcon = UIImage(named: "smileIcon")!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(25.2048, 55.2708), 50000, 50000)
		let adjustedRegion = self.myMapView.regionThatFits(viewRegion)
		self.myMapView.setRegion(adjustedRegion, animated: false)
		
		self.myMapView.showsUserLocation = true
		self.myMapView.zoomEnabled = true
		
		
		let james = UIImage(named: "jamesIcon")!
		let kady = UIImage(named: "kadyIcon")!
		let atm = UIImage(named: "atmIcon")!
		
		self.myMapView.addAnnotation(MyAnnotation(lat: 25.204, lng: 55.27, text: "James is here...", pin: james))
		self.myMapView.addAnnotation(MyAnnotation(lat: 25.104, lng: 55.27, text: "Kady is here...", pin: kady))
		self.myMapView.addAnnotation(MyAnnotation(lat: 25.104, lng: 55.17, text: "ATM is here...", pin: atm))
	}

	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if let myAnnotation = annotation as? MyAnnotation {
			let btn = UIButton(type: .Custom)
			btn.frame.size.width = 45
			btn.frame.size.height = 52
			btn.backgroundColor = UIColor.greenColor()
			btn.setImage(accessoryIcon, forState: .Normal)
			
			
			let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")	// TODO : consider to dequeue objects instead of initiating new ones
			pin.canShowCallout = true
			pin.image = myAnnotation.pin
			pin.leftCalloutAccessoryView = btn
			
			return pin
		}
		return nil
	}

}


class MyAnnotation : NSObject, MKAnnotation {
	private let coord: CLLocationCoordinate2D
	private let text: String
	let pin: UIImage
	
	var coordinate: CLLocationCoordinate2D {
		get {
			return coord
		}
	}
	
	var title: String? {
		get {
			return text
		}
	}
	
	init(lat: Double, lng: Double, text: String, pin: UIImage) {
		self.coord = CLLocationCoordinate2DMake(lat, lng)
		self.text = text
		self.pin = pin
		
	}
}