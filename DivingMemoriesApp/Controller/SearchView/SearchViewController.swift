//
//  SearchViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/21.
//

import UIKit


class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, XMLParserDelegate {
    
    
    
    
    
    
    var tableViewLabelNAme = ["ボニンブルー","","川平石崎マンタスクランブル","","大瀬崎"]
    

    
    
    var width = UIScreen.main.bounds.size.width
    var height = UIScreen.main.bounds.size.height
    
    //セルの間閣用
    let cellSpacingHeight:CGFloat = 5
    
    @IBOutlet weak var newsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsTableView.reloadData()
        
        
    }
    
    
    
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            
            return 0
        }else if section == 1{
            
            
            return tableViewLabelNAme.count
        }else if section == 2{
            
            
            return 3
        }
        
        
        return section
    }
    
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1{
            
            
            switch indexPath.row {
            
            
            case 0 :
                return height / 10
            
            case 1 :
               return 10
            case 2 :
                return height / 10
            case 3 :
               return 10
            case 4 :
                return height / 10
                
            default : return height / 10
            
            }
            
        
    }
        return height / 10
    }
    
    //セルの構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        if indexPath.section == 0 {
            cell.backgroundColor = .clear

        }else if indexPath.section == 1 {
            
            
            
            if indexPath.row == 0{
                
                cell.textLabel?.text = tableViewLabelNAme[0]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 1{
            
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 2{
                
                cell.textLabel?.text = tableViewLabelNAme[2]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 3{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 4{
                cell.textLabel?.text = tableViewLabelNAme[4]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }
            
            
            
        }else if indexPath.section == 2{
            
            
        }
        
        
   
        return cell
        
        
    }
    
    //セルを押した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        
        //セクション0
        if indexPath.section == 0{

        }else if indexPath.section == 1{
            
            
            //セクション1
            if indexPath.row == 0{
                performSegue(withIdentifier: "NextView01", sender: nil)
            }else if indexPath.row == 2{
                performSegue(withIdentifier: "NextView02", sender: nil)
            }else if indexPath.row == 4{
                performSegue(withIdentifier: "NextView03", sender: nil)
               
            }
            
            
            //セクション2
            }else if indexPath.section == 2{
                
                if indexPath.row == 0{
                    
                }else if indexPath.row == 1{
                    
                }else if indexPath.row == 2{
            
            
        }
        
        
        }
        
        
        
       
    }
    
    //ヘッダータイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        if section == 0{
            return "Recommendation"
            
            
        }else if section == 1{
            
            
            
            return "オススメスポット"
        }else if section == 2{
            
            
            return ""
            
            
        }
            
            
            
            

            return "kakikukeko"
            
        }
        
    //フッタータイトル
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
 
        
        if section == 0{
            
            
            return ""
            
            
        }else if section == 1{
            
            return ""
        }else if section == 2{
            
            return ""
        }
        
            return "naninuneno"
            
        }
        

    //ヘッダーの間隔(（（例）セクション０のフッターとセクション１もヘッダー)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        if section == 0{

            return 30
        }else{
            
            return 50
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0{
 
            return cellSpacingHeight
        }else if section == 1{
            
            
            return 1
        }else{
            
            return 2
        
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       
        view.tintColor = UIColor.clear // 透明にすることでスペースとする
        
        switch section{
        
        case 0 :
      
            view.tintColor = .brown
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .darkGray
            header.textLabel?.font = UIFont(name: "Futara", size: 21)
    
        case 1 :
            
           
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont(name: "Marion", size: 17)
            
            
        default : return
        }
        
        
      
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor.clear // 透明にすることでスペースとする
      
    }
    
    
  
}
