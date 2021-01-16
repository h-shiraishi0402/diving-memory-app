//
//  DivingRecordDetailViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2021/01/15.
//

import UIKit
import Firebase
import FirebaseFirestore


class DivingRecordDetailViewController: UIViewController {

    var divingData = [DivingRecordData]()
    var db = Firestore.firestore()
    var uid = FirebaseAuth.Auth.auth().currentUser?.uid
    var user = FirebaseAuth.Auth.auth().currentUser
    
    
    @IBOutlet var inTime: UILabel!
    @IBOutlet var outTime: UILabel!
    @IBOutlet var startingPressure: UILabel!
    @IBOutlet var endPressure: UILabel!
    @IBOutlet var airTemperature: UILabel!
    @IBOutlet var waterTemperature: UILabel!
    @IBOutlet var transparency: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var memo:UILabel!

    //潜水地
    var divingGroundTitle = String()

    //日付
    var dateTextField = String()

    //開始時間
    var inTimes = String()

    //終了時間
    var outTimes = String()

    //開始圧力
    var startingPressures = String()

    //終了圧力
    var endPressures = String()

    //気温
    var airTemperatures = String()

    //水温
    var waterTemperatures = String()

    //透視度
    var transparencys = String()

    //透視度タイプ
    var permeability_typs = String()

    //ウェイト
    var weights = String()

    //ウェイトタイプ
    var w_type = String()

    var comment = String()
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inTime.text = inTimes
        outTime.text = outTimes
        startingPressure.text = startingPressures
        endPressure.text = endPressures
        airTemperature.text = airTemperatures
        waterTemperature.text = waterTemperatures
        transparency.text = transparencys
        weight.text = weights
        memo.text = comment
        
        print(inTimes)
    }
    
    
    
    
    func load(){
        
        let ref = db.collection("DivingRecord")
        
        let reference = ref.whereField("user", isEqualTo: uid ?? "" )
        
        divingData = []
        
        
            reference.getDocuments { (querySnapshot, error) in
            
                if error != nil {
                    print(error.debugDescription)
                    
                }
                
               
                self.divingData = (querySnapshot?.documents.map{  document -> DivingRecordData in
                    
                    let data = DivingRecordData(document: document)
                    return data

                    
                })!
        
        
        
        
    }
    
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
