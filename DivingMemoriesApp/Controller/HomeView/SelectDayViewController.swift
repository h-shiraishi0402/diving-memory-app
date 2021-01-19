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
//gifの表示に必要
import SwiftGifOrigin
//cocoapodsのライブラリー読み込みの時のくるくるに必要
import PKHUD

class SelectDayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextViewDelegate{
    
    var width = UIScreen.main.bounds.size.width
    var height = UIScreen.main.bounds.size.height
    
    var testTodo:[TodoData] = []
    var selectDay = Int()
    var selectYear = Int()
    var selectMounth = Int()
    var id_count = 0
    var udf_count = "id_count"
    
    var db = Firestore.firestore()
    var user = Firebase.Auth.auth().currentUser
    var uid = Auth.auth().currentUser?.uid
    var docId = String()
    
    @IBOutlet var addObj: UIButton!
    @IBOutlet var year: UILabel!
    @IBOutlet var mounthAndDay: UILabel!
    @IBOutlet var addTodoTablView: UITableView!
    
    //------------↑↑↑↑↑Global variables↑↑↑↑------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newId = UserDefaults.standard.integer(forKey: udf_count)
        id_count = newId
        print("newID*\(id_count)")
        
        //読み込み
        loadTodo()
        
        addTodoTablView.delegate = self
        addTodoTablView.dataSource = self
        addTodoTablView.reloadData()
        
        addObj.layer.cornerRadius = 25
        addObj.clipsToBounds = true
        self.addTodoTablView.allowsSelection = true
        
        //labelに表示
        year.text = "\(selectYear)年"
        mounthAndDay.text = String("\(selectMounth)月\(selectDay)日")
        
        //カスタムセルのやーつ
        addTodoTablView.register(UINib(nibName: "TodoCellSection1Cell", bundle: nil), forCellReuseIdentifier: "Cell1")
        addTodoTablView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTodo()
    }
    //fireStoreのロード
    func loadTodo(){
        
        let reftest = db.collection("Todo")
        let ref = reftest.whereField("date2", isEqualTo: "\(selectYear)年\(selectMounth)月\(selectDay)日" ).whereField("user", isEqualTo: uid ?? "")
        self.testTodo = []
        ref.getDocuments { [self] (querySnapshot, error) in
            //errorの場合
            if error != nil{
                print(error.debugDescription)
                return
            }
            self.testTodo = (querySnapshot?.documents.map { document -> TodoData in
                let data = TodoData(document: document)
                
                return data
            })!
            addTodoTablView.reloadData()
        }
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTodo.count
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セル構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section02_Cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TodoCell
        let todo = testTodo[indexPath.row]
        section02_Cell.selectionStyle = .none
        
        if todo.user == Auth.auth().currentUser?.uid{
            //if todo.title == db.document("Todo").documentID{
            section02_Cell.taitleLabel.text = todo.title
            section02_Cell.numberOfPeopleLabel.text = "\(todo.numberOfPeople!)人"
            section02_Cell.budgetLabel.text = todo.budget
            section02_Cell.dutchTreatLabel.text = "割り勘金額\(todo.dutchTreat!) 円"
            section02_Cell.memoLabel.delegate = self
            section02_Cell.memoLabel.isEditable = false
            section02_Cell.memoLabel.isSelectable = false
            section02_Cell.memoLabel.text = todo.memo
        }
        return section02_Cell
        
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 250
        
    }
    //セルをタップしたら
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TodoAddVc"{
            let TodoVc = segue.destination as! AddScheduleViewController
            TodoVc.selectYear = selectYear
            TodoVc.selectMounth = selectMounth
            TodoVc.selectDay = selectDay
        }
    }
    //Todo作成_AddButton
    @IBAction func addTodoButton(_ sender: Any) {
        performSegue(withIdentifier: "TodoAddVc", sender: nil)
    }
    //各indexPathのcellが編集(削除，移動等)を行えるか指定します
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let todo = testTodo[indexPath.row]
        
        docId = db.collection("Todo").document("\(todo.docId ?? "")").documentID
        print(docId)
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //公式参照(firebaseから削除)
            db.collection("Todo").document("\(docId)").delete() { err in
                
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            //cellの削除
            testTodo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
