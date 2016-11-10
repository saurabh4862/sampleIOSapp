//
//  ViewController.swift
//  NoddAssign
//
//  Created by Adarsh Kolluru on 10/7/16.
//  Copyright © 2016 Saurabh. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class ViewController: UIViewController,GMSMapViewDelegate {
    
    @IBOutlet weak var filterControl: UISegmentedControl!
    var locationManager = CLLocationManager()
    var vwGMap:GMSMapView!
    var dict = [[String:AnyObject]]()
    var activity:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vwGMap = GMSMapView()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(19.0760, longitude: 72.3777, zoom: 8.0)
        let frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: self.view.bounds.height-90)
        vwGMap = GMSMapView.mapWithFrame(frame, camera: camera)
        vwGMap.camera = camera
        self.view.addSubview(vwGMap)
        vwGMap.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        activity.activityIndicatorViewStyle = .WhiteLarge
        view.addSubview(activity)
        activity.startAnimating()
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        
        Alamofire.request(.GET, "https://private-2e7e02-singup.apiary-mock.com/data").responseJSON{
            response in
            print(response.result)
           
            if let JSON = response.result.value {
                self.dict = JSON as! [[String:AnyObject]]
                self.showData(self.dict)
                self.activity.stopAnimating()
                
            }
            
        }
        
    }
    
    func showData(Dict:[[String:AnyObject]]){
        var marker:GMSMarker!
        for i in 0...Dict.count-1{
            
            let array = Dict[i]["coordinate"] as! [Double]
            let coordinate = CLLocationCoordinate2D(latitude: array[0], longitude: array[1])
           
            if Dict[i]["type"] as! String == "ex"{
            marker  = GMSMarker(position:coordinate)
            marker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
            marker.userData = Dict[i]
            marker.map = self.vwGMap
            }
            if Dict[i]["type"] as! String == "pe"{
                 marker  = GMSMarker(position:coordinate)
                marker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
                marker.userData = Dict[i]
                marker.map = self.vwGMap
            }
            if Dict[i]["type"] as! String == "ev"{
                 marker  = GMSMarker(position:coordinate)
                marker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
                marker.userData = Dict[i]
                marker.map = self.vwGMap
            }
        
            
        }
    }
    func filterDict(str:String){
        self.vwGMap.clear()
        var data = [[String:AnyObject]]()
        
        for i in 0...self.dict.count-1{
            if dict[i]["type"] as! String == str{
                data.append(dict[i])
                
            }
            
        }
        showData(data)
        
    }


    @IBAction func Filters(sender: AnyObject) {
        
        switch filterControl.selectedSegmentIndex
        {
        case 0:
            showData(self.dict)
        
        case 1:
            filterDict("ex")
        
        case 2:
            filterDict("ev")
        
        case 3:
            filterDict("pe")
        
        default:
            break
        
        }
        
    }
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewViewController")
         as! NewViewController
        viewController.dict = marker.userData as! [String:AnyObject]
        
        self.navigationController?.pushViewController(viewController, animated: true)
        return true
        
        
    }
}

