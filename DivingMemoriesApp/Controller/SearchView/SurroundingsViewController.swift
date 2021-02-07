//
//  SurroundingsViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/12/19.
//


/*
 
 1.天気
 2.
 3.
 4.周辺食事
 
 
 
 
 
 */











import UIKit
import MapKit
import SDWebImage
import Alamofire
import SwiftyJSON

class SurroundingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet var tableView: UITableView!
    
    
    var cellNameArray = ["WEATHER","RESTURANT","SHOP","LOADING"]
    var imageArray = ["landscape-3369304_1920","Restaurant","Air","Lodging"]

    
    var indexNum = Int()
    var titleString = String()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
            
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        
    }
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cellNameArray.count

    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let cellImageView = cell.contentView.viewWithTag(1) as! UIImageView

        cellImageView.image = UIImage(named: imageArray[indexPath.row])

        //room名
        let cellName = cell.contentView.viewWithTag(2) as! UILabel
        cellName.text = cellNameArray[indexPath.row]
        
        
        
        
        
//
//        switch indexPath.row{
//
//
//        case 0:
//
//
//        case 1:
//
//        case 2:
//
//        case 3:
//
//
//
//        default: return cell
//
//
//        }








        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/4
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(indexPath.row)


        switch indexPath.row{

       
        case 0:
            print(indexPath.row)

            print("0")
        case 1:
            indexNum = 1
            performSegue(withIdentifier: "SurroundingVc", sender: nil)
            break
        

//        case 1:
//
//
//
//        case 2:
//
//
//
//        case 3:
//

        

        default: return


        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SurroundingVc"{
            
        let SurroundingVc = self.storyboard?.instantiateViewController(identifier: "SurroundingVc") as!  Surrounding_MealsViewController
        SurroundingVc.titleString = cellNameArray[indexNum]
            
        }
    }

    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
