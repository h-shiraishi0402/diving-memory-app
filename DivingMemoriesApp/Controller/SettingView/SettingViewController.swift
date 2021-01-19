//
//  SettingViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import EMAlertController
import PKHUD
import FirebaseCore
import Photos


protocol  ProfileString {
    func  profileString(nicName:String,ownedLicense:String,image:Data)
}



class SettingViewController:UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var grt = UINotificationFeedbackGenerator()//振動させる＜UIKit＞
    let db = Firestore.firestore()
    
    var Count:Int = 0
    var pickerCount:String = ""
    
    @IBOutlet weak var nickNameCreatTextField :UITextField!
    @IBOutlet weak var ageCreatTextField :UITextField!
    @IBOutlet weak var sexCreatTextField :UITextField!
    @IBOutlet weak var ownedLicenseCreatTextField :UITextField!
    @IBOutlet weak var divingHistoryCreatTextField :UITextField!
    @IBOutlet weak var finishButtonObject: UIButton!//フィニッシュボタンのオブジェクト
    @IBOutlet weak var addNewLabel: UILabel!
    @IBOutlet var logOutButtonObj: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ownedLicenseLabel: UILabel!
    @IBOutlet weak var divingHistoryLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    
    
    var checkPermission = CheckPermission()
    var profileString:ProfileString?
    var sendToModel = SendToModel()
    
    
    var urlString = String()
    var ImageUrl = String()
    var imageData:String?
    
   
    
    
    var  Nickname:String = ""//ニックネーム
    var  Sex:String = ""//性別
    var  age:String = ""//年齢
    var  OwnedLicense:String = ""//所有ライセンス
    var  Divinghistory:String = ""//ダイビング歴
    
    //
    var profileValue = profileValueModel()
    var sexArray = [String]()
    var ageArray = [String]()
    var OwnedLicenseArray = [String]()
    var DivinghistoryArray = [String]()
    
    
    var SexPicker = UIPickerView()
    var AgePicker = UIPickerView()
    var OwnedLiicensePicker = UIPickerView()
    var DivinghistoryPicker = UIPickerView()
 
    //------------↑↑↑↑↑Global variables↑↑↑↑------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textViewのピッカー用の値
        sexArray = profileValue.profileValue["sexArray"]!
        ageArray = profileValue.profileValue["ageArray"]!
        OwnedLicenseArray = profileValue.profileValue["OwnedLicenseArray"]!
        DivinghistoryArray = profileValue.profileValue["DivinghistoryArray"]!
        //ピッカーの作成
        createPickerView()
        //カメラ使用許可画面
        checkPermission.showCheckPermission()
    
        nickNameCreatTextField.delegate = self
        sexCreatTextField.delegate = self
        ageCreatTextField.delegate = self
        ownedLicenseCreatTextField.delegate = self
        divingHistoryCreatTextField.delegate = self
        AgePicker.delegate = self
        SexPicker.delegate = self
        OwnedLiicensePicker.delegate = self
        DivinghistoryPicker.delegate = self
        OwnedLiicensePicker.dataSource = self
        DivinghistoryPicker.dataSource = self
        AgePicker.dataSource = self
        SexPicker.dataSource = self
        
        nickNameCreatTextField.layer.cornerRadius = 20
        nickNameCreatTextField.clipsToBounds = true
        ageCreatTextField.layer.cornerRadius = 20
        ageCreatTextField.clipsToBounds = true
        sexCreatTextField.layer.cornerRadius = 20
        sexCreatTextField.clipsToBounds = true
        ownedLicenseCreatTextField.layer.cornerRadius = 20
        ownedLicenseCreatTextField.clipsToBounds = true
        divingHistoryCreatTextField.layer.cornerRadius = 20
        divingHistoryCreatTextField.clipsToBounds = true
        finishButtonObject.layer.cornerRadius = 20
        finishButtonObject.clipsToBounds = true
        addNewLabel.layer.cornerRadius = 20
        addNewLabel.clipsToBounds = true
        nickNameLabel.layer.cornerRadius = 20
        nickNameLabel.clipsToBounds = true
        ageLabel.layer.cornerRadius = 20
        ageLabel.clipsToBounds = true
        sexLabel.layer.cornerRadius = 20
        sexLabel.clipsToBounds = true
        ownedLicenseLabel.layer.cornerRadius = 20
        ownedLicenseLabel.clipsToBounds = true
        divingHistoryLabel.layer.cornerRadius = 20
        divingHistoryLabel.clipsToBounds = true
        logOutButtonObj.layer.cornerRadius = 20
        logOutButtonObj.clipsToBounds = true
        
       
        
        //空白チェック
        null_Judgment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバーを消す
        self.navigationController?.isNavigationBarHidden = true
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
    
    
    //カメラ撮影orアルバムから画像選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if info[.originalImage] as? UIImage != nil{
            
            // 選択した写真を取得する
            let selectedImage = info[.originalImage] as! UIImage
            //セットする
            profileImage.image = selectedImage
            //picker閉じる（戻る）
            picker.dismiss(animated: true, completion: nil)
            
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
    
    
    //完了時
    @IBAction func FinishButton(_ sender: Any) {

        
        if let image = profileImage.image{
            
            Nickname = nickNameCreatTextField.text!
            Sex = sexCreatTextField.text!
            age = ageCreatTextField.text!
            OwnedLicense = ownedLicenseCreatTextField.text!
            Divinghistory = divingHistoryCreatTextField.text!
            UserDefaults.standard.set(Nickname,forKey: "Nickname")
            UserDefaults.standard.set(Sex,forKey: "Sex")
            UserDefaults.standard.set(age,forKey: "age")
            UserDefaults.standard.set(OwnedLicense,forKey: "OwnedLicense")
            UserDefaults.standard.set(Divinghistory,forKey: "Divinghistory")
            
            
            let data = image.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.set(data,forKey: "image")
            ImageUrl = "OK"
            self.sendToModel.sendProfileImage(data: data!)
            profileString?.profileString(nicName: Nickname, ownedLicense: OwnedLicense,image: data!)
            
            
            
            //戻る
            dismiss(animated: true, completion: nil)
            
            //振動させる
            grt.notificationOccurred(.error)
        }
 
        
        
    }
    
    
    
    
    
    
    //Firebaseに送信
    func Send_DB(){
    
     
        
        HUD.show(.progress)
 
        
        db.collection("Profile").document("\(String(describing: Auth.auth().currentUser?.uid))").setData(
            
            [  "Nickname":nickNameCreatTextField.text as Any
               ,"sexCreatTextField":sexCreatTextField.text as Any
               ,"Age":ageCreatTextField.text as Any
               ,"OwnedLicense":ownedLicenseCreatTextField.text as Any ,"Divinghistory":divingHistoryCreatTextField.text as Any])
        
        
        //HOME画面遷移
        self.performSegue(withIdentifier: "HOME", sender: nil)
        
        
        
        
     
        
        
    }
    
    
    //空白判定andアプリ内に保存
    func null_Judgment(){
        
        let imageData = UserDefaults.standard.data(forKey: "image")
        let Nickname = UserDefaults.standard.object(forKey: "Nickname")
        let age =  UserDefaults.standard.object(forKey: "age")
        let Sex =  UserDefaults.standard.object(forKey: "Sex")
        let OwnedLicense = UserDefaults.standard.object(forKey: "OwnedLicense")
        let Divinghistory =  UserDefaults.standard.object(forKey: "Divinghistory")
        
        
        
        
        if imageData != nil  {
            
            profileImage.image = UIImage(data: imageData!)
            
        }
        
        
        
        if Nickname != nil  {
            
            nickNameCreatTextField.text = (Nickname as! String)
        }else{
            
            nickNameCreatTextField.text = ""
            
        }
        
        if Sex != nil  {
            
            sexCreatTextField.text = (Sex as! String)
        }else{
            
            sexCreatTextField.text = ""
            
        }
        if age != nil  {
            
            ageCreatTextField.text = (age as! String)
        }else{
            
            ageCreatTextField.text = ""
            
        }
        if OwnedLicense != nil  {
            
            ownedLicenseCreatTextField.text = (OwnedLicense as! String)
        }else{
            
            ownedLicenseCreatTextField.text = ""
            
        }
        if Divinghistory != nil  {
            
            divingHistoryCreatTextField.text = (Divinghistory as! String)
        }else{
            
            divingHistoryCreatTextField.text = ""
            
        }
        
        
    }
    
    //イメージをタップしたら
    @IBAction func tapImageView(_ sender: Any) {
        
        //アラートを出す
        showAlert()
    }
    
    
    //ピッカーの作成
    func createPickerView() {
        
        /*
         ここでやりたい事はピッカーの作成
         */
        
        //
        ageCreatTextField.inputView = AgePicker
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let doneButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        ageCreatTextField.inputAccessoryView = toolbar
        
        
        
        
        //
        sexCreatTextField.inputView = SexPicker
        
        let SexPickertoolbar = UIToolbar()
        SexPickertoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let SexPickerdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        SexPickertoolbar.setItems([SexPickerdone], animated: true)
        sexCreatTextField.inputAccessoryView = SexPickertoolbar
        
        
        
        //
        ownedLicenseCreatTextField.inputView = OwnedLiicensePicker
        
        let OwnedLiicensetoolbar = UIToolbar()
        OwnedLiicensetoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let OwnedLiicensePickerdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        OwnedLiicensetoolbar.setItems([OwnedLiicensePickerdone], animated: true)
        ownedLicenseCreatTextField.inputAccessoryView = OwnedLiicensetoolbar
        
        
        
        //
        divingHistoryCreatTextField.inputView = DivinghistoryPicker
        
        let Divinghistorytoolbar = UIToolbar()
        Divinghistorytoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let Divinghistorydone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        Divinghistorytoolbar.setItems([Divinghistorydone], animated: true)
        divingHistoryCreatTextField.inputAccessoryView = Divinghistorytoolbar
        
        
        
        
        
    }
    
    
    //ピッカーを押したらの挙動
    @objc func donePicker(picker: UIPickerView) {
        //pickerを押したときの挙動

        
        if picker == AgePicker {
            ageCreatTextField.endEditing(true)
            
        }else if picker == SexPicker{
            sexCreatTextField.endEditing(true)
            
            
        }else if picker == OwnedLiicensePicker{
            ownedLicenseCreatTextField.endEditing(true)
            
            
        }else if picker == DivinghistoryPicker{
            divingHistoryCreatTextField.endEditing(true)
            
        }else{
            ageCreatTextField.endEditing(false)
            sexCreatTextField.endEditing(false)
            ownedLicenseCreatTextField.endEditing(false)
            divingHistoryCreatTextField.endEditing(false)
            
        }
    
    }
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
     
        return 1
    }
    
    //ピッカーの行数
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        
        if picker == AgePicker {
            return ageArray.count
            
        }else if picker == SexPicker{
            return sexArray.count
            
            
        }else if picker == OwnedLiicensePicker{
            return OwnedLicenseArray.count
            
            
        }else if picker == DivinghistoryPicker{
            return DivinghistoryArray.count
            
        }
        
      
        return Count
        
        
    }
    
    
    // UIPickerViewに表示する配列
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        
        
        if picker == AgePicker{
            
            //pickerCount = ageArray[row]
            return ageArray[row] as String
            
        }else if picker == SexPicker {
            //pickerCount = sexArray[row]
            return sexArray[row] as String
            
            
        }else if picker == OwnedLiicensePicker{
            //pickerCount = OwnedLicenseArray[row]
            return OwnedLicenseArray[row] as String
            
            
        }else if picker == DivinghistoryPicker{
            //pickerCount = DivinghistoryArray[row]
            return DivinghistoryArray[row] as String
            
        }

        
        return pickerCount
    }
    

    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
        
        if picker == AgePicker {
            ageCreatTextField.text = ageArray[row]
            
        }else if picker == SexPicker{
            sexCreatTextField.text = sexArray[row]
            
            
            
        }else if picker == OwnedLiicensePicker{
            ownedLicenseCreatTextField.text = OwnedLicenseArray[row]
            
            
            
        }else if picker == DivinghistoryPicker{
            divingHistoryCreatTextField.text = DivinghistoryArray[row]
            
            
        }
     
        
    }
    
    
    //戻る
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //キーボードEnterで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        
        textField.resignFirstResponder()
        
       
        return true
        
    }
    
    
    //キーボードタッチで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      
        
    }
    
    
    //ログアウト
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "LogOut", sender: nil)
        } catch let err {
            print(err)
        }
        
        
    }
    
    
   
 
    
    
    

    
    
}
