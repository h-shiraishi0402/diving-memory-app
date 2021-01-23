//
//  AnalysisModel.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/08.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol SendValuProtocol {
    
    func sendData(arrayData:Array<ShopModel>,result:Int)
    func setName(name:[String],url:[String],image:[String])
}




class AnalysisModel {
    
    var latitudeValue = Double()
    var longitudeValue  = Double()
    var urlString = String()
    var shopModel = [ShopModel]()
    var sendValueProtocol:SendValuProtocol?
    var name = [String]()
    var url = [String]()
    var image = [String]()
    
    //外部から値を受け取る
    init(latitude:Double,longitude:Double,url:String) {
        latitudeValue = latitude
        longitudeValue = longitude
        urlString = url
    }
    
    
    //解析開始
    func setData(){
        //エンコーディングする
        let encordingUrl:String =  (urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        
      
        AF.request(encordingUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { [self] (response) in
            
            
            
            switch response.result {
            
            case .success :
                
                do{
                    
                    let json:JSON = try JSON(data: response.data!)
                    var totalHitCount = json["total_hit_count"].int
                    
                    if totalHitCount! > 50{
                        
                        totalHitCount = 50
                        
                    }
                    
                    
                    for i in 0...totalHitCount! - 1{
                        
                        
                        //空では無いものを取得していく。
                        if  json["rest"][i]["url_mobile"] != "" && json["rest"][i]["name"] != "" && json["rest"][i]["name_kana"] != "" && json["rest"][i]["latitude"] != "" && json["rest"][i]["longitude"] != "" && json["rest"][i]["address"] != "" && json["rest"][i]["address"] != "" && json["rest"][i]["tel"] != "" && json["rest"][i]["image_url"]["shop_image1"] != "" {
                            
                            //配列に値を格納していく
                            let shopData = ShopModel(name: json["rest"][i]["name"].string, name_kana: json["rest"][i]["name_kana"].string, latitude: json["rest"][i]["latitude"].string, longitude: json["rest"][i]["longitude"].string, address: json["rest"][i]["address"].string, tel: json["rest"][i]["tel"].string, shop_image1: json["rest"][i]["image_url"]["shop_image1"].string,url: json["rest"][i]["url_mobile"].string)
                            
                            shopModel.append(shopData)
                            name.append(shopData.name!)
                            url.append(shopData.url!)
                            image.append(shopData.shop_image1!)
                            
                        
                            print("zzzzzzzzzzz\(name)")
                            print(shopModel.debugDescription)
                            
                            
                        }else{
                            
                            print("エラー")
                            
                            
                        }
                        
                        
                    }
                    
                    //プロトコルに値をセット
                    sendValueProtocol?.sendData(arrayData: shopModel, result: shopModel.count)
                    sendValueProtocol?.setName(name: name,url: url, image: image)
                    
                    
                }catch{
                    
                    
                    print(response.debugDescription)
                    
              
                }
                break
                case .failure: print(response.debugDescription)
                break
                    
                
                
                
                
                
                
                
            }
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
}








