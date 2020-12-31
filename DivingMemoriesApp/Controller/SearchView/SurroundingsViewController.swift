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

class SurroundingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    
    @IBOutlet var tableView: UITableView!
    
    var cellNameArray = ["weather","","",""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 1
        
        default: return 1
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return cellNameArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    
        
        switch indexPath.section{
        
        
        case 0:
            if indexPath.row == 0{

            }else{
                
                
            }
            
        case 1:
            if indexPath.row == 0{

            }else{
                
                
            }
        case 2:
            if indexPath.row == 0{

            }else{
                
                
            }
        case 3:
            if indexPath.row == 0{

            }else{
                
                
            }
            
            
        default: return cell
            
        
        
        
        
        
        
        
        }
        
        
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section{
        
        
        case 0:
            if indexPath.row == 0{

            }else{
                
                
            }
            
        case 1:
            if indexPath.row == 0{

            }else{
                
                
            }
        case 2:
            if indexPath.row == 0{

            }else{
                
                
            }
        case 3:
            if indexPath.row == 0{

            }else{
                
                
            }
            
        default: return
        
        
        }
        
    }

}
