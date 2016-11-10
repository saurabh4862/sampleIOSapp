//
//  NewViewController.swift
//  NoddAssign
//
//  Created by Adarsh Kolluru on 10/13/16.
//  Copyright © 2016 Saurabh. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
    var dict:[String:AnyObject]!

    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = dict["type"] as? String
        label3.text = dict["title"] as? String
        let array = dict["coordinate"] as! [Double]
        
        label2.text = "location is \(array[0]) , \(array[1])"

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
