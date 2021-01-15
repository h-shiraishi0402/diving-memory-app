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
    var uid :String?
    
    //潜水地
    var divingGroundTitle:String
    
    //日付
    var dateTextField:String
    
    var user:String?
    
    
    
    
    
    init(document: QueryDocumentSnapshot){
        
        
        
        self.uid = document.documentID
        let docData = document.data()
        dateTextField = docData["createTime_02"] as! String
        divingGroundTitle = document["title"] as! String
        user = docData["user"] as? String
        
        
    
        
        
    }
    
    
    
}
