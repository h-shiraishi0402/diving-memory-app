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
    var errorColor:UIColor = UIColor(red: 252, green: 122, blue: 98, alpha: 1)//エラー時にTextFieldのバックグラウンド用
    
    
    
    let CreatUserDB = Firestore.firestore()//.collection("Profile").document("wRrch36bfI0FFh4YUpGX")
    
    var Count:Int = 0
    var pickerCount:String = ""
    
    @IBOutlet weak var NicknameCreat :UITextField!
    @IBOutlet weak var AgeCreat :UITextField!
    @IBOutlet weak var SexCreat :UITextField!
    @IBOutlet weak var OwnedLicenseCreat :UITextField!
    @IBOutlet weak var DivinghistoryCreat :UITextField!
    @IBOutlet weak var FinishButtonObject: UIButton!//フィニッシュボタンのオブジェクト
    @IBOutlet weak var addNewLabel: UILabel!
    @IBOutlet var logOutObj: UIButton!
    
    @IBOutlet weak var NicknameLabel: UILabel!
    @IBOutlet weak var SexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var OwnedLicenseLabel: UILabel!
    @IBOutlet weak var DivinghistoryLabel: UILabel!
    
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
    var sexArray = [" ","男","女"]
    var ageArray = [" ","10歳","11歳","12歳","13歳","14歳","15歳","16歳","17歳","18歳","19歳","20歳","21歳","22歳","23歳","24歳","25歳","26歳","27歳","28歳","29歳","30歳","31歳","32歳","33歳","34歳","35歳","36歳","37歳","38歳","39歳","40歳","41歳","42歳","43歳","44歳","45歳","46歳","47歳","48歳","49歳","50歳以上"]
    var OwnedLicenseArray = [" ","スクーバ・ダイバー","オープンウォーター・ダイバー","アドバンスド・アドベンチュラー・ダイバー","アドバンスド・オープンウォーター・ダイバー","レスキューダイバー","マスターダイバー","ダイブマスター","アシスタントインストラクター","オープンウォーター・インストラクター"
                             ,"マスター・インストラクター","インストラクター・トレーナー","コースディレクター"]
    
    var DivinghistoryArray = ["1年未満","1年〜3年","4年〜5年","5年〜10年","10年以上"]
    
    
    var SexPicker = UIPickerView()
    var AgePicker = UIPickerView()
    var OwnedLiicensePicker = UIPickerView()
    var DivinghistoryPicker = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad_START***********************")
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        createPickerView()
        //カメラ使用許可画面
        checkPermission.showCheckPermission()
        
        
        NicknameCreat.delegate = self
        SexCreat.delegate = self
        AgeCreat.delegate = self
        OwnedLicenseCreat.delegate = self
        DivinghistoryCreat.delegate = self
        AgePicker.delegate = self
        SexPicker.delegate = self
        OwnedLiicensePicker.delegate = self
        DivinghistoryPicker.delegate = self
        OwnedLiicensePicker.dataSource = self
        DivinghistoryPicker.dataSource = self
        AgePicker.dataSource = self
        SexPicker.dataSource = self
        
        
        
        
        NicknameCreat.layer.cornerRadius = 20
        NicknameCreat.clipsToBounds = true
        AgeCreat.layer.cornerRadius = 20
        AgeCreat.clipsToBounds = true
        SexCreat.layer.cornerRadius = 20
        SexCreat.clipsToBounds = true
        OwnedLicenseCreat.layer.cornerRadius = 20
        OwnedLicenseCreat.clipsToBounds = true
        DivinghistoryCreat.layer.cornerRadius = 20
        DivinghistoryCreat.clipsToBounds = true
        FinishButtonObject.layer.cornerRadius = 20
        FinishButtonObject.clipsToBounds = true
        addNewLabel.layer.cornerRadius = 20
        addNewLabel.clipsToBounds = true
        NicknameLabel.layer.cornerRadius = 20
        NicknameLabel.clipsToBounds = true
        ageLabel.layer.cornerRadius = 20
        ageLabel.clipsToBounds = true
        SexLabel.layer.cornerRadius = 20
        SexLabel.clipsToBounds = true
        OwnedLicenseLabel.layer.cornerRadius = 20
        OwnedLicenseLabel.clipsToBounds = true
        DivinghistoryLabel.layer.cornerRadius = 20
        DivinghistoryLabel.clipsToBounds = true
        logOutObj.layer.cornerRadius = 20
        logOutObj.clipsToBounds = true
        
        
        null_Judgment()
        
        
        print("viewDidLoad_END***********************")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NicknameCreat.keyboardType = .default
        
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
            profileImage.image = selectedImage
            
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
        //Log用
        print("FinishButton_START***********************")
        
        if let image = profileImage.image{
            
            Nickname = NicknameCreat.text!
            Sex = SexCreat.text!
            age = AgeCreat.text!
            OwnedLicense = OwnedLicenseCreat.text!
            Divinghistory = DivinghistoryCreat.text!
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
            
            
            
            
            dismiss(animated: true, completion: nil)
            
            
            grt.notificationOccurred(.error)
        }
        print("FinishButton_END***********************")
        
        
    }
    
    
    
    
    
    
    //Firebaseに送信
    func Send_DB(){
        //Log用
        print("func Send_DB_START***********************")
        
        HUD.show(.progress)
        
        //値をDBに送信する
        //        Auth.auth().createUser(withEmail: EmailAddressCreat.text!, password: PasswordCreat.text!)
        //
        
        
        CreatUserDB.collection("Profile").document("\(String(describing: Auth.auth().currentUser?.uid))").setData(
            
            [  "Nickname":NicknameCreat.text as Any
               ,"SexCreat":SexCreat.text as Any
               ,"Age":AgeCreat.text as Any
               ,"OwnedLicense":OwnedLicenseCreat.text as Any ,"Divinghistory":DivinghistoryCreat.text as Any])
        
        
        //HOME画面遷移
        self.performSegue(withIdentifier: "HOME", sender: nil)
        
        
        
        
        print("func Send_DB_END***********************")
        
        
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
            
            NicknameCreat.text = (Nickname as! String)
        }else{
            
            NicknameCreat.text = ""
            
        }
        
        if Sex != nil  {
            
            SexCreat.text = (Sex as! String)
        }else{
            
            SexCreat.text = ""
            
        }
        if age != nil  {
            
            AgeCreat.text = (age as! String)
        }else{
            
            AgeCreat.text = ""
            
        }
        if OwnedLicense != nil  {
            
            OwnedLicenseCreat.text = (OwnedLicense as! String)
        }else{
            
            OwnedLicenseCreat.text = ""
            
        }
        if Divinghistory != nil  {
            
            DivinghistoryCreat.text = (Divinghistory as! String)
        }else{
            
            DivinghistoryCreat.text = ""
            
        }
        
        
    }
    
    //イメージをタップしたら
    @IBAction func tapImageView(_ sender: Any) {
        
        //アラートを出す
        showAlert()
    }
    
    
    
    func createPickerView() {
        
        /*
         ここでやりたい事はピッカーの作成
         */
        
        //
        AgeCreat.inputView = AgePicker
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let doneButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        AgeCreat.inputAccessoryView = toolbar
        
        
        
        
        //
        SexCreat.inputView = SexPicker
        
        let SexPickertoolbar = UIToolbar()
        SexPickertoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let SexPickerdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        SexPickertoolbar.setItems([SexPickerdone], animated: true)
        SexCreat.inputAccessoryView = SexPickertoolbar
        
        
        
        //
        OwnedLicenseCreat.inputView = OwnedLiicensePicker
        
        let OwnedLiicensetoolbar = UIToolbar()
        OwnedLiicensetoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let OwnedLiicensePickerdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        OwnedLiicensetoolbar.setItems([OwnedLiicensePickerdone], animated: true)
        OwnedLicenseCreat.inputAccessoryView = OwnedLiicensetoolbar
        
        
        
        //
        DivinghistoryCreat.inputView = DivinghistoryPicker
        
        let Divinghistorytoolbar = UIToolbar()
        Divinghistorytoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let Divinghistorydone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        Divinghistorytoolbar.setItems([Divinghistorydone], animated: true)
        DivinghistoryCreat.inputAccessoryView = Divinghistorytoolbar
        
        
        
        
        
    }
    
    
    //ピッカーを押したらの挙動
    @objc func donePicker(picker: UIPickerView) {
        //pickerを押したときの挙動
        print("donePicker_START***********************")
        
        if picker == AgePicker {
            AgeCreat.endEditing(true)
            
        }else if picker == SexPicker{
            SexCreat.endEditing(true)
            
            
        }else if picker == OwnedLiicensePicker{
            OwnedLicenseCreat.endEditing(true)
            
            
        }else if picker == DivinghistoryPicker{
            DivinghistoryCreat.endEditing(true)
            
        }else{
            AgeCreat.endEditing(false)
            SexCreat.endEditing(false)
            OwnedLicenseCreat.endEditing(false)
            DivinghistoryCreat.endEditing(false)
            
        }
        print("donePicker_END***********************")
    }
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("numberOfComponents_START***********************")
        print("---------------------------------")
        print("numberOfComponents_END***********************")
        return 1
    }
    
    //ピッカーの行数
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("numberOfComponents_START***********************")
        
        if picker == AgePicker {
            return ageArray.count
            
        }else if picker == SexPicker{
            return sexArray.count
            
            
        }else if picker == OwnedLiicensePicker{
            return OwnedLicenseArray.count
            
            
        }else if picker == DivinghistoryPicker{
            return DivinghistoryArray.count
            
        }
        
        
        print("-----------\(Count)----------------------")
        print("numberOfComponents_END***********************")
        return Count
        
        
    }
    
    
    // UIPickerViewに表示する配列
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("titleForRow, forComponent_START***********************")
        
        
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
        print("titleForRow, forComponent_END***********************")
        
        return pickerCount
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
    
    
    
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(" didSelectRow, inComponent_START***********************")
        
        if picker == AgePicker {
            AgeCreat.text = ageArray[row]
            
        }else if picker == SexPicker{
            SexCreat.text = sexArray[row]
            
            
            
        }else if picker == OwnedLiicensePicker{
            OwnedLicenseCreat.text = OwnedLicenseArray[row]
            
            
            
        }else if picker == DivinghistoryPicker{
            DivinghistoryCreat.text = DivinghistoryArray[row]
            
            
        }
        print(" didSelectRow, inComponent_END***********************")
        
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //キーボードEnterで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn_Strat***********************")
        
        textField.resignFirstResponder()
        
        print("textFieldShouldReturn_END*************************")
        return true
        
    }
    
    
    //キーボードタッチで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        print("touchesBegan_START***********************")
        
        print("touchesBegan_END*************************")
        
    }
    
    
    
}
