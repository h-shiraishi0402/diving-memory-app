//
//  SearchViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/21.
//

import UIKit


class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, XMLParserDelegate {
    
    
    
    
    
    
    var tableViewLabelName = [
        "ボニンブルー",
        "",
        "川平石崎マンタスクランブル",
        "",
        "大瀬崎",
        "",
        "_",
        "",
        "_",
        "",
        "_",
        "",
        "_",
        "",
        "_",
    ]
    
    
    
    
    var width = UIScreen.main.bounds.size.width
    var height = UIScreen.main.bounds.size.height
    var indexNum = Int()
    
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
            
            
            return tableViewLabelName.count
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
            
            
            case 0, 2,4,6,8,10,12,14 :
                return height / 10
                
            case 1,3,5,7,9,11,13 :
                return 10
                
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
                
                cell.textLabel?.text = tableViewLabelName[0]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 1{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 2{
                
                cell.textLabel?.text = tableViewLabelName[2]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 3{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 4{
                cell.textLabel?.text = tableViewLabelName[4]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 5{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 6{
                
                cell.textLabel?.text = tableViewLabelName[6]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 7{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 8{
                
                cell.textLabel?.text = tableViewLabelName[8]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 9{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 10{
                cell.textLabel?.text = tableViewLabelName[10]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 11{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 12{
                
                cell.textLabel?.text = tableViewLabelName[12]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
                
            }else if indexPath.row == 13{
                
                cell.backgroundColor = UIColor.clear
                
            }else if indexPath.row == 14{
                cell.textLabel?.text = tableViewLabelName[14]
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                cell.textLabel?.font = UIFont(name: "Heofler Text", size: 19)
            }
            
            
            return cell
            
            
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
                indexNum = 0
                performSegue(withIdentifier: "NextView01", sender: nil)
            }else if indexPath.row == 2{
                indexNum = 1
                performSegue(withIdentifier: "NextView01", sender: nil)
            }else if indexPath.row == 4{
                indexNum = 2
                performSegue(withIdentifier: "NextView01", sender: nil)
                
            }
            
            
            //セクション2
        }else if indexPath.section == 2{
            
            if indexPath.row == 0{
                
            }else if indexPath.row == 1{
                
            }else if indexPath.row == 2{
                
                
            }
            
            
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NextView01") {
            let rec: RecommendedViewController = (segue.destination as? RecommendedViewController)!
            
            if indexNum == 0{
            rec.tagNum = 0
            }else if indexNum == 1{
                rec.tagNum = 1
            }else if indexNum == 2{
                rec.tagNum = 2
            }
            else if indexNum == 3{
                rec.tagNum = 3
            }
            else if indexNum == 4{
                rec.tagNum = 4
            }
            
            
            
            
            
            
            
            
            
            
        }
    }
    
    
    //ヘッダータイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "Recommendation"
            
        }else if section == 1{
            
            return "オススメスポット"
        }
        
        
        
        
        return ""
        
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
    
    //ヘッダーの間隔(（（例）セクション０のフッターとセクション１noヘッダー)
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


