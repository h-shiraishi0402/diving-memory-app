//
//  TodoTest.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/12/07.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class TodoData {
    
    var uid :String?
    var title :String?
    var date:String?
    var numberOfPeople:String?
    var budget:String?
    var dutchTreat:String?
    var memo:String?
    var date2:String?
    var user:String?
    
    init(document: QueryDocumentSnapshot){
        
        
        
        self.uid = document.documentID
        let docData = document.data()
        title = docData["title"] as? String
        date = docData["date"] as? String
        numberOfPeople = docData["numberOfPeople"] as? String
        budget = docData["budget"] as? String
        dutchTreat = docData["dutchTreat"] as? String
        memo = docData["memo"] as? String
        date2 = docData["date3"] as? String
        user = docData["user"] as? String
        
    }
}
