//
//  Surrounding_MealsViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/08.
//

import UIKit
import MapKit
import SDWebImage
import PKHUD

//TableViewのイメージ反映について＜ どうしよう・・・非同期処理で表示させる？？/11/13
//コードにコメントつけなきゃ・・・ 11/15




class Surrounding_MealsViewController: UIViewController,SendValuProtocol,CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    var latitudeValue = Double()
    var longitudeValue = Double()
    var urlValue = String()
    let apiKey:String = "c91bca10c13a6bb6ac36a1147dd3c267"
    var total_hit_count = Int()
    var indexNumber = Int()
    
    var shopDataArray = [ShopModel]()
    let locationManager = CLLocationManager()
    var name = [String]()
    var url = [String]()
    var image = [String]()
    var testCount = Int()
    
    var titleString = String()
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    // @IBOutlet weak var imageView: UIImageView!
    
  
    @IBOutlet var textView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        startUpdatingLocation()
        configuerSubView()
        
        textView.layer.cornerRadius = 5
        textField.clipsToBounds = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tableView.reloadData()
    }
 
    func check(num: Int) {
        if num == 1{
            tableView.reloadData()
        }
    }
    
    
    //位置情報を取得して良いかの許可する画面の作成
    func startUpdatingLocation(){
        
        
        locationManager.requestAlwaysAuthorization()
        
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy{
            //現在地を取得してスタートさせる(取得していく)
            locationManager.startUpdatingLocation()
        }
        
    }
    //ステータスの処理を分ける場合
    // アプリがロケーション マネージャを作成したとき、および承認ステータスが変更されたときに、委任者に通知
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            
            break
        case .notDetermined, .denied, .restricted:
            
            break
        default:
            print("Unhandled case")
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy: break
        case .fullAccuracy: break
        default:
            print("This should not happen!")
        }
        
    }
    
    
    //これが無いと緯度経度を決め打ちするしかにない・・・・
    func configuerSubView(){
        
        locationManager.delegate = self
        //精度の事
        /*
         kCLLocationAccuracyBest：最高精度
         */
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        
        /*
         requestWhenInUseAuthorizationは、アプリまたは、その機能が画面上に表示されている時だけ、位置情報の利用を許可するもので、アプリがバックグラウンド状態の時は、許可されない。
         */
        locationManager.requestWhenInUseAuthorization()
        
        
        //位置情報取得間隔を指定する
        locationManager.distanceFilter = 10
        
        //GPSの使用を開始する
        locationManager.startUpdatingLocation()
        
        
        
        
        
    }
    
    //現在の緯度と緯度経度の取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //一番最初にとってこれた場所を格納する
        let location = locations.first
        
        //緯度
        let latitude = location?.coordinate.latitude
        latitudeValue = latitude!
        //経度
        let longitude = location?.coordinate.longitude
        longitudeValue = longitude!
    }
    
    
    
    
    
    
    @IBAction func setButton(_ sender: Any) {
        
        HUD.show(.progress)
        
        
        
           
         
        
        let urlString = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apiKey)&latitude=\(latitudeValue)&longitude=\(longitudeValue)&range=3&hit_per_page=50&freeword=\(textField.text!)"
        
        //通信を行います
        let analysisModel = AnalysisModel(latitude: latitudeValue, longitude: longitudeValue, url: urlString)
        
        analysisModel.sendValueProtocol = self
        analysisModel.setData()
        name.append(contentsOf: analysisModel.name)
        url.append(contentsOf: analysisModel.url)
        urlValue.append(contentsOf: analysisModel.urlString)
        image.append(contentsOf: analysisModel.image)
        textField.resignFirstResponder()
        

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) { [self] in
        
        tableView.reloadData()
            HUD.flash(.success, delay: 1.0)
         }
    }
    
    
    
    func setName(name: [String],url:[String],image:[String]) {
        self.name = [String]()
        self.name.append(contentsOf: name)
        print("nameカウント：\(self.name.count)")
        self.url = [String]()
        self.url.append(contentsOf: url)
        print("urlカウント：\(self.url.count)")
        self.image = [String]()
        self.image.append(contentsOf: image)
        print("imageカウント：\(self.image.count)")
        tableView.reloadData()
        
        
        
    }
    
    
    func sendData(arrayData: Array<ShopModel>, result: Int) {
        
        shopDataArray = arrayData
        print("shopDataArrayカウント：\(self.shopDataArray.count)")
        
        total_hit_count = result
        print("total_hit_countカウント：\(self.total_hit_count)")
    }
    
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopDataArray.count
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    
    //セルの構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_res", for: indexPath)
        
        cell.layer.cornerRadius = 5
        
        testCount += 1
        print(testCount)

        
        let cellImageView = cell.contentView.viewWithTag(1) as! UIImageView

        cellImageView.sd_setImage(with: URL(string: image[indexPath.row]))
        cellImageView.layer.cornerRadius = 5

        //room名
        let cellName = cell.contentView.viewWithTag(2) as! UILabel
        cellName.text = name[indexPath.row]
        
        
        let contentsView = cell.contentView.viewWithTag(3)!
        contentsView.layer.cornerRadius = 5
        
        
        return cell
    }
    
    
    
    //セルをタップした際
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        indexNumber = Int()
        indexNumber = indexPath.row
        
        performSegue(withIdentifier: "Cell_res2", sender: url[indexPath.row])
        
        
        
        
    }
    
    //画面遷移した際に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let datailVC = segue.destination as! DetailViewController
        
        datailVC.url = sender as! String
        datailVC.image = image[indexNumber]
        
    }
    
    //タップでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      
    }
    
    
    //ReturnKeyを押したらキーボードが閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if image.count == testCount{
            tableView.reloadData()
            
            
        }
        textField.text = ""
        return true
    }
    
    
    
    //一つ前に戻る
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    
}


//"https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=c91bca10c13a6bb6ac36a1147dd3c267&latitude=35.4459&longitude=139.6356893&range=3&hit_per_page=50&freeword=居酒屋"
