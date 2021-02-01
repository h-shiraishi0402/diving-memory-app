//
//  DivingRecordDetailViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2021/01/15.
//

import UIKit
import Firebase
import FirebaseFirestore
import Photos
import EMAlertController


class DivingRecordDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var divingData = [DivingRecordData]()
    var db = Firestore.firestore()
    var uid = FirebaseAuth.Auth.auth().currentUser?.uid
    var user = FirebaseAuth.Auth.auth().currentUser
    
    
    
    @IBOutlet var backImageSet: UIImageView!
    var backimage = Data()
    
    @IBOutlet var inTime: UILabel!
    @IBOutlet var outTime: UILabel!
    @IBOutlet var startingPressure: UILabel!
    @IBOutlet var endPressure: UILabel!
    @IBOutlet var airTemperature: UILabel!
    @IBOutlet var waterTemperature: UILabel!
    @IBOutlet var transparency: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var memo: UITextView!
    
    

    
    var checkPermission = CheckPermission()

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
    
    
    var imagTag = 0
    var imageNum = Int()
    
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let useImagedata =  UserDefaults.standard.object(forKey: "imageset\(imageNum)")
        
        print("reVcaaaaaaaa:\(imageNum)")
        if useImagedata != nil{
            
            self.backImageSet.image = UIImage(data: useImagedata as! Data)
        }else{
            backImageSet.image = UIImage(named: "no_image")
        }

        //編集出来ないようにする
        memo.isEditable = false
        
        
        //インタイム
        inTime.text = "IN TIME:\(inTimes)"
        outTime.text = "OUT TIME:\(outTimes)"
        startingPressure.text = "開始 圧力:\(startingPressures)"
        endPressure.text = "終了 圧力:\(endPressures)"
        airTemperature.text = "気温:\(airTemperatures)℃"
        waterTemperature.text = "水温:\(waterTemperatures)℃"
        transparency.text = "透視度:\(transparencys + " " + permeability_typs  )"
        weight.text = "ウェイト:\(weights + " " + w_type)"
        memo.text = comment
        
        //カメラ使用許可画面
        checkPermission.showCheckPermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    //カメラ立ち上げメソッド
    
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            
        }
        
    }
    
    //アルバム
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    //画像設定時
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if info[.originalImage] as? UIImage != nil{
            let selectedImage = info[.originalImage] as! UIImage
            backImageSet.image = selectedImage
            backimage = selectedImage.jpegData(compressionQuality: 1.0)!
            UserDefaults.standard.set(backimage, forKey: "imageset\(imageNum)")
            picker.dismiss(animated: true, completion: nil)
            print("aaaaaaaaaa\(selectedImage)")
        
        }
        
    }
    //キャンセルした時
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    //アラート
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
            
        }
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
            
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func imageset(_ sender: Any) {
        showAlert()
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
 
}
