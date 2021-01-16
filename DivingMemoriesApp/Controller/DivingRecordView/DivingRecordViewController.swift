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
    
    /*
     //着手予定12/01
     */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RecorListTableView.dataSource = self
        RecorListTableView.delegate = self
        
        
        
        // NavigationBarを非表示
              

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        listLoad()
        RecorListTableView.reloadData()

        
    }
    
    
    
    
    func listLoad(){
        
        let ref = db.collection("DivingRecord")
        
        
        let reference = ref.whereField("user", isEqualTo: uid ?? "")
        recordList = []
        
        
        
        reference.getDocuments { [self] (snapshot, error) in
       
        
    
            if error != nil {
             
                print(error.debugDescription)
                return
            }
            
            
 
            recordList = (snapshot?.documents.map{ docment -> DivingRecordData  in
                
                if error != nil {
               
                    print("")
                    
                }
                
               let data = DivingRecordData(document: docment)
                
                return data
                
            })!

            RecorListTableView.reloadData()
            
        }
        
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        return recordList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drData = recordList[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "drCell")
        
        
        if drData.user == Auth.auth().currentUser?.uid{
            
            cell.textLabel?.text = drData.divingGroundTitle
            cell.detailTextLabel?.text = drData.dateTextField


        }
 
        return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexNum = indexPath.row
        //セルを押したら次の画面
        performSegue(withIdentifier: "DivingRecordDetailView", sender: nil)
        //次の画面に値を渡す
        
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DivingRecordDetailView"{
            
            
            let drData = recordList[indexNum]
            print()
            
            let RecordDetail = segue.destination as! DivingRecordDetailViewController
            RecordDetail.inTimes = drData.inTime
            RecordDetail.outTimes = drData.outTime
            RecordDetail.startingPressures = drData.startingPressure
            RecordDetail.endPressures = drData.endPressure
            RecordDetail.airTemperatures = drData.airTemperature
            RecordDetail.waterTemperatures = drData.waterTemperature
            RecordDetail.weights = drData.weight// + drData.w_type
            RecordDetail.transparencys = drData.transparency// + drData.permeability_typ
            RecordDetail.comment = drData.comment
            
            
            
            
            
            
            
            
            
            
            
        }
        
    }
        
        
    
    
    

}
