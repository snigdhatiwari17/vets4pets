//
//  MapKitViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 23/07/23.
//


import UIKit
import RealmSwift
import MapKit

class MapViewController: LocationVCViewController {
    
    
    @IBOutlet weak var durationLabel: UITextField!
    @IBOutlet weak var distanceLabel: UITextField!
    
    @IBOutlet weak var lastDurationLabel: UILabel!
    @IBOutlet weak var lastDistanceLabel: UILabel!
    @IBOutlet weak var lastRunCloseButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!  //refrence to the embedded map in the screen
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    
    var coordinateLocations = List<Location>() //collection of location objects, defined in Location.Swift
    
    var timer = Timer()
    var walkDistance = 0.0
    var counter = 0
    
    @IBOutlet weak var lastRunStack: UIStackView!
    @IBOutlet weak var lastRunBackgroundView: UIView!
    
    override func viewDidLoad() { //called when the view is first opened
        super.viewDidLoad()
        checkLocationAuthStatus() //calling the function which checks the authorisation status
        mapView.delegate = self //sets the delegate of the mapview as this view controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.distanceFilter = 10 //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpMapView() //calls the map view
    }
    
    @IBAction func lastRunClosedPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBackgroundView.isHidden = true
        lastRunCloseButton.isHidden = true
    }
    
    func startWalk(){
        manager?.startUpdatingLocation()
        startTimer()
        
    }
    
    func setUpMapView(){
        if let overlay = addLastWalkToMap() { //checks is overlay is nil or not, if it is not nil, overlay = MKPolyline
            
            if mapView.overlays.count > 0 { //checks if current map view already has an overlay
                mapView.removeOverlays(mapView.overlays) //removes previous overlays if any are present
            }
            
            mapView.addOverlay(overlay) //adds overlay to map view
            
            lastRunStack.isHidden = false //hides last run view
            lastRunBackgroundView.isHidden = false //hides last run view
            lastRunCloseButton.isHidden = false //hides last run view
        }
        else {
            lastRunStack.isHidden = true //shows last run view
            lastRunBackgroundView.isHidden = true //shows last run view
            lastRunCloseButton.isHidden = true //shows last run view
        }
    }
    
    
    func addLastWalkToMap()-> MKPolyline? { //returns a MKPolyline object
        guard let lastWalk = Walk.getAllWalks()?.first else { return nil} // grabs the first walk from the database
        
        lastDistanceLabel.text = (String(format: "%02d", lastWalk.distance)) //updates the last distance label
        lastDurationLabel.text = lastWalk.duration.formatTimeDurationToString() //updates the last timing label
        
        
        var coordinates = [CLLocationCoordinate2D]() //initialises empty array of CLLocationCoordinate2D objects
        
        for location in lastWalk.locations { //for loop adding CLLocationCoordinate2D objects to the coordinates array
            coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        return MKPolyline(coordinates: coordinates, count: lastWalk.locations.count)
    }
    
    
    
    
    
    func endWalk(){
        manager?.stopUpdatingLocation()
        
        Walk.addWalkToRealm(distance: walkDistance , duration: counter, locations: coordinateLocations) // walk object containing list of location objects is added to database
        walkDistance = 0.0
        counter = 0
        durationLabel.text = counter.formatTimeDurationToString()
        distanceLabel.text = "Distance: \(String(format: "%02d", walkDistance))m"
    }
    
    
    func pauseWalk(){
        
        startLocation = nil
               lastLocation = nil
               timer.invalidate()
          manager?.stopUpdatingLocation()
       
    }
    
    func startTimer(){
        durationLabel.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    @objc func updateCounter(){
        counter += 1
        durationLabel.text = counter.formatTimeDurationToString()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
   
    @IBAction func stopWalkingPressed(_ sender: Any) {
        endWalk()
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        if timer.isValid {
            pauseWalk()
        }else {
            startWalk()
        }
    }
    
    @IBAction func startWalkingPressed(_ sender: Any) {
        startWalk()
    }
    
    @IBAction func locationCenterButtonPressed(_ sender: Any) {
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //function called automatically everytime the user's location updates
        if startLocation == nil {
            startLocation = locations.first //first item in locations array
        } else if let location = locations.last {
            walkDistance += lastLocation.distance(from: location)
            
            let newLocation = Location(latitude: Double(lastLocation.coordinate.latitude), longitude: Double(lastLocation.coordinate.longitude))
            //creating a new location object
            
            coordinateLocations.insert(newLocation, at: 0) //new location object inserted to start of the list, every object is moved down the list one place
            
            distanceLabel.text = "Distance: \(String(format: "%.2f", walkDistance))m"
        }
        lastLocation = locations.last
    }
    
    
    
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer { //returns an overaly renderer
        let polyline = overlay as! MKPolyline //creates a polyline that is equal to the overlay passed into the function casted as MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline) //creates renderer, so polyline can be shown on mapview
        renderer.strokeColor = .red //design of the polyline
        renderer.lineWidth = 4
        return renderer
    }
    
}
