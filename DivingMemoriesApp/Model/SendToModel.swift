//
//  SendToModel.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/15.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    
    
    func sendProfileOKDelegate(url:String)
    
}


class SendToModel{
    
    
    var sendProfileOKDelegate:SendProfileOKDelegate?

    
    
    init() {
        
    }
    
    
    
    func sendProfileImage(data:Data){
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        

        
        imageRef.putData(profileImageData!, metadata:nil) { (metaData, error) in
            
            if error != nil{
            
                print(error.debugDescription)
                return
            }
            
            
            imageRef.downloadURL { [self] (url, error) in
                    
                if error != nil{
                
                    print(error.debugDescription)
                    return
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
                
               
                
            }
            
            //ここ2
            
            
        }
        
        //ここ1
        
    }
    
    
}
