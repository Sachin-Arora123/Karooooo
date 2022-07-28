//
//  UserDetailVC.swift
//  Karooooo
//
//  Created by Sachin on 27/07/22.
//

import UIKit
import MapKit
class UserDetailVC: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblSuite: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblZipcode: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    var detailUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        dropPinOnLocation()
    }
    func showData() {
        lblName.text = detailUser?.name
        lblUsername.text = detailUser?.username
        lblEmail.text = detailUser?.email
        lblStreet.text = detailUser?.address?.street
        lblSuite.text = detailUser?.address?.suite
        lblCity.text = detailUser?.address?.city
        lblZipcode.text = detailUser?.address?.zipcode
        lblPhone.text = detailUser?.phone
        lblWebsite.text = detailUser?.website
        lblCompanyName.text = detailUser?.company?.name
    }
    func dropPinOnLocation() {
        if let latitude = detailUser?.address?.geo?.lat, let longitude = detailUser?.address?.geo?.lng {
            if let latitudeValue = Double(latitude), let longitudeValue = Double(longitude) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
