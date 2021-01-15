//
//  DivingRecordModel.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2021/01/07.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct DivingRecordModel {
    
    //潜水地
    var divingGroundTitle = String()
    
    //日付
    var dateTextField = String()
    
    //開始時間
    var inTime = String()
    
    //終了時間
    var outTime = String()
    
    //開始圧力
    var startingPressure = String()
    
    //終了圧力
    var endPressure = String()
    
    //気温
    var airTemperature = String()
    
    //水温
    var waterTemperature = String()
    
    //透視度
    var transparency = String()
    
    //透視度タイプ
    var permeability_typ = String()
    
    //ウェイト
    var weight = String()
    
    //ウェイトタイプ
    var w_type = String()
    

    
}
