//
//  SelectDayViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/12/04.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import AVFoundation
import SwiftGifOrigin
import PKHUD


//次にやるこては、DB値を送信



class SelectDayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextViewDelegate{
    
    
    var width = UIScreen.main.bounds.size.width
    var height = UIScreen.main.bounds.size.height
    
    var player = AVPlayer()
    
    var todoArray:[TodoModel] = []
    var testTodo:[TodoData] = []
    var titleArray = [String]()
    var selectDay = Int()
    var selectYear = Int()
    var selectMounth = Int()
    var roomName = String()
    
    var uid = Auth.auth().currentUser?.uid
    var docId = String()
    
    
    
    var db = Firestore.firestore()
    var user = Firebase.Auth.auth().currentUser

    
    var indexnum = Int()

    
    @IBOutlet var addObj: UIButton!
    
    @IBOutlet var year: UILabel!
    @IBOutlet var mounthAndDay: UILabel!
    
    @IBOutlet var addTodoTablView: UITableView!
    
    var id_count = 0
    var udf_count = "id_count"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newId = UserDefaults.standard.integer(forKey: udf_count)
        id_count = newId
        print("newID*\(id_count)")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) { [self] in
        
            HUD.show(.progress)
            addTodoTablView!.reloadData()
            HUD.hide()
         }
   

        
        loadTodo()
        
        addTodoTablView.delegate = self
        addTodoTablView.dataSource = self
        addTodoTablView.reloadData()
        
        
        
        
        addObj.layer.cornerRadius = 25
        addObj.clipsToBounds = true
        self.addTodoTablView.allowsSelection = true
       
        
       
//        let image = UIImage.pngData("海2")
//        backImage.image = image

        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
//
//
//
//        // APNGファイルのパスを取得
//                guard let path = Bundle.main.path(forResource: "海3", ofType: "png") else { return }
//
//                // APNGのファイルを取得
//                let image = APNGImage(contentsOfFile: path)
//
//                // imageViewにAPNGを代入
//                backImage.image = image
//
//                // アニメーションの実行
//                backImage.startAnimating()
//        }
 

        
        
        year.text = "\(selectYear)年"
        mounthAndDay.text = String("\(selectMounth)月\(selectDay)日")
        
        
      
        
        addTodoTablView.delegate = self
        addTodoTablView.dataSource = self
        
        addTodoTablView.register(UINib(nibName: "TodoCellSection1Cell", bundle: nil), forCellReuseIdentifier: "Cell1")
        addTodoTablView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
      
        loadTodo()
      
        
    
    }
    
    
    
    func loadTodo(){
        
    
        
        let reftest = db.collection("Todo")
        
        
        let ref = reftest.whereField("date2", isEqualTo: "\(selectYear)年\(selectMounth)月\(selectDay)日" ).whereField("user", isEqualTo: uid ?? "")
        
        self.testTodo = []
        
    
        
        ref.getDocuments { [self] (querySnapshot, error) in
            
            if error != nil{
                print(error.debugDescription)
                
                return
            }
            
            
          
            
            
            
            
            self.testTodo = (querySnapshot?.documents.map { document -> TodoData in
                
                
                let data = TodoData(document: document)
                
            
                
                print("wwwwwwwwwwwwwwwwwwwww\(data)")
                print("dddddddddddddddddddd\(testTodo.count)")
                return data
                
                
                
                
            })!
            
           
            
  
           
                addTodoTablView.reloadData()
               
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
       
        return testTodo.count
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        
        
        let section02_Cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TodoCell
        let todo = testTodo[indexPath.row]
        section02_Cell.selectionStyle = .none
      
        
        
        if todo.user == Auth.auth().currentUser?.uid{
        //if todo.title == db.document("Todo").documentID{
        
        
        section02_Cell.taitleLabel.text = todo.title
        //section02_Cell.dateLabel.text = todo.date
        section02_Cell.numberOfPeopleLabel.text = "\(todo.numberOfPeople!)人"
        section02_Cell.budgetLabel.text = todo.budget
        section02_Cell.dutchTreatLabel.text = "割り勘金額\(todo.dutchTreat!) 円"
        section02_Cell.memoLabel.delegate = self
        section02_Cell.memoLabel.isEditable = false
        section02_Cell.memoLabel.isSelectable = false
        section02_Cell.memoLabel.text = todo.memo
        
        
        
        }else{
      
        
            
            
            
            
        }
        // }
        
        
        
        return section02_Cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 250
        
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を変数に入れる
        
        
        if segue.identifier == "TodoAddVc"{
            
            let TodoVc = segue.destination as! AddScheduleViewController
            
            
            TodoVc.selectYear = selectYear
            TodoVc.selectMounth = selectMounth
            TodoVc.selectDay = selectDay
            
            
            
        }else{
            
            
        }
        
        
    }
    
    
    @IBAction func addTodoButton(_ sender: Any) {
        
    
        performSegue(withIdentifier: "TodoAddVc", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
       {
           return true
       }

       //スワイプしたセルを削除　※arrayNameは変数名に変更してください
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let todo = testTodo[indexPath.row]
        
        docId = db.collection("Todo").document("\(todo.docId ?? "")").documentID
        print(docId)
        
           if editingStyle == UITableViewCell.EditingStyle.delete {
            
            
            db.collection("Todo").document("\(docId)").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
   
            
               testTodo.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
           }
        
       }
    



    
    





////
//ALL
//DivingRecord
//
//Profile
//
//Todo
}
