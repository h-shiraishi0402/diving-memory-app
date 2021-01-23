//
//  DivingRecordViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class DivingRecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var RecorListTableView: UITableView!
    
    
    var recordList:[DivingRecordData] = []
    var db = Firestore.firestore()
    var user = Firebase.Auth.auth().currentUser
    var uid = Auth.auth().currentUser?.uid
    var indexNum = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecorListTableView.dataSource = self
        RecorListTableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバー非表示
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //ロード実行
        listLoad()
        //tableView更新
        RecorListTableView.reloadData()
    }
    //対象のものをfirebaseから取得(ロード)
    func listLoad(){
        let ref = db.collection("DivingRecord")
        //ユーザのもだけ取得する為
        let reference = ref.whereField("user", isEqualTo: uid! )//uid ?? ""
        
        //初期化
        recordList = []

        reference.getDocuments { [self] (snapshot, error) in
 
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            recordList = (snapshot?.documents.map{ docment -> DivingRecordData  in
                
                let data = DivingRecordData(document: docment)
                return data
            })!
            //ソート
            recordList.sort { (lcreateTime, rcreateTime) -> Bool in
                return lcreateTime.createTime < rcreateTime.createTime
            }
            //リロード
            RecorListTableView.reloadData()
        }
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    //セルの構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drData = recordList[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "drCell")
        //ユーザのものかどうかの判別
        if drData.user == Auth.auth().currentUser?.uid{
            cell.textLabel?.text = drData.divingGroundTitle
            cell.detailTextLabel?.text = drData.dateTextField
        }
        return cell
    }
    //セルを選択したら
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNum = indexPath.row
        //セルを押したら次の画面
        //次の画面に値を渡す
        performSegue(withIdentifier: "DivingRecordDetailView", sender: nil)
    }
    //値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DivingRecordDetailView"{
            
            
            let drData = recordList[indexNum]
            print()
            let RecordDetail: DivingRecordDetailViewController = (segue.destination as? DivingRecordDetailViewController)!
            RecordDetail.inTimes = drData.inTime
            RecordDetail.outTimes = drData.outTime
            RecordDetail.startingPressures = drData.startingPressure
            RecordDetail.endPressures = drData.endPressure
            RecordDetail.airTemperatures = drData.airTemperature
            RecordDetail.waterTemperatures = drData.waterTemperature
            RecordDetail.weights = drData.weight
            RecordDetail.transparencys = drData.transparency
            RecordDetail.comment = drData.comment
            RecordDetail.permeability_typs = drData.permeability_typ
            RecordDetail.w_type = drData.w_type
            RecordDetail.imageNum = indexNum
            print("\(indexNum):aaaaaaaaaa")
            
        }
        
    }
    
}
