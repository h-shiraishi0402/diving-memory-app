//
//  DivingRecordData.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2021/01/15.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


class DivingRecordData {
    //id
    var uid:String?
    
    //潜水地
    var divingGroundTitle:String

    //日付
    var dateTextField:String

    //開始時間
    var inTime:String

    //終了時間
    var outTime:String

    //開始圧力
    var startingPressure:String

    //終了圧力
    var endPressure:String

    //気温
    var airTemperature:String

    //水温
    var waterTemperature:String

    //透視度
    var transparency:String

    //透視度タイプ
    var permeability_typ:String

    //ウェイト
    var weight:String

    //ウェイトタイプ
    var w_type:String
    
    var comment:String
    
    
    var user:String?
    
    
    var createTime:Double
    
    
    
    
    
    
    init(document: QueryDocumentSnapshot){
        
        
        
        self.uid = document.documentID
        let docData = document.data()
        divingGroundTitle = document["title"] as! String
        dateTextField = docData["createTime_02"] as! String
        inTime = document["inTime"] as! String
        outTime = document["outTime"] as! String
        startingPressure = document["startingPressure"] as! String
        endPressure = document["endPressure"] as! String
        airTemperature = document["airTemperature"] as! String
        waterTemperature = document["waterTemperature"] as! String
        transparency = document["transparency"] as! String
        permeability_typ = document["transparency_type"] as! String
        weight = document["weight"] as! String
        w_type = document["weight_type"] as! String
        comment = document["comment"] as! String
        createTime = document["createTime"] as! Double
        user = docData["user"] as? String
        
      
    }
    
    
    
    
}



