//
//  AddDivingRecordViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol DiviingValue {
    func diviingValue(set:DivingRecordModel)
    
}



class AddDivingRecordViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate{
    
    
    var diviingSetValue:DiviingValue?
    var divingRecordModel = DivingRecordModel()
    
    
    let divingGroundTitlePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let inTimePicker = UIDatePicker()
    let outTimePicker = UIDatePicker()
    let startingPressurePicker = UIPickerView()
    let endPressurePicker = UIPickerView()
    let airTemperaturePicker = UIPickerView()
    let waterTemperaturePicker = UIPickerView()
    let transparencyPicker = UIPickerView()
    let weightPicker = UIPickerView()
    
    
    @IBOutlet var doneButtonObj: UIButton!
    
    
    //潜水地
    @IBOutlet var divingGroundTitle: UITextField!
    //日付
    @IBOutlet var dateTextField: UITextField!
    //開始時間
    @IBOutlet var inTime: UITextField!
    //終了時間
    @IBOutlet var outTime: UITextField!
    //開始圧力
    @IBOutlet var startingPressure: UITextField!
    //終了圧力
    @IBOutlet var endPressure: UITextField!
    //気温
    @IBOutlet var airTemperature: UITextField!
    //水温
    @IBOutlet var waterTemperature: UITextField!
    //透視度
    @IBOutlet var transparency: UITextField!
    //透視度タイプ
    @IBOutlet var permeability_typ: UITextField!
    //ウェイト
    @IBOutlet var weight: UITextField!
    //ウェイトタイプ
    @IBOutlet var w_type: UITextField!
    //コメント
    @IBOutlet var commentTextViewObj: UITextView!
    
    
    var tspy_type = [" ","ft","m"]
    var type = [" ","lbs","kg"]
    
    var recordeArray = [DivingRecordModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        doneButtonObj.layer.cornerRadius = 5
        doneButtonObj.clipsToBounds = true
        
        
        
        
        divingGroundTitle.layer.cornerRadius = 5
        divingGroundTitle.clipsToBounds = true
        divingGroundTitle.placeholder = "入力してください"
        
        
        dateTextField.delegate = self
        dateTextField.placeholder = "入力してください"
        
        inTime.delegate = self
        inTime.placeholder = "入力してください"
        
        outTime.delegate = self
        outTime.placeholder = "入力してください"
        
        startingPressure.delegate = self
        startingPressure.placeholder = "入力してください"
        
        endPressure.delegate = self
        endPressure.placeholder = "入力してください"
        
        airTemperature.delegate = self
        airTemperature.placeholder = "入力してください"
        
        waterTemperature.delegate = self
        waterTemperature.placeholder = "入力してください"
        
        transparency.delegate = self
        transparency.placeholder = "入力してください"
        
        weight.delegate = self
        weight.placeholder = "入力してください"
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        transparencyPicker.delegate = self
        transparencyPicker.dataSource = self
        
        commentTextViewObj.delegate = self
        commentTextViewObj.backgroundColor = .white
        commentTextViewObj.text = "コメント"
        commentTextViewObj.textColor = UIColor.lightGray
    
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createPicker()
        
        
    }
    
    
    
    
    
    
    func createPicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        // textFieldのinputViewにdatepickerを設定
        dateTextField.inputView = datePicker
        datePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        // Doneボタンを追加
        toolbar.setItems([doneButton], animated: true)
        
        // FieldにToolbarを追加
        dateTextField.inputAccessoryView = toolbar
        
        
        
        
        
        
        
        inTimePicker.datePickerMode = .time
        outTimePicker.datePickerMode = .time
        
        inTimePicker.locale = Locale(identifier: "ja_JP")
        outTimePicker.locale = Locale(identifier: "ja_JP")
        
        inTimePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        outTimePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        
        inTimePicker.addTarget(self, action: #selector(doneClicked), for: .valueChanged)
        outTimePicker.addTarget(self, action: #selector(doneClicked), for: .valueChanged)
        
        inTimePicker.minuteInterval = 10
        outTimePicker.minuteInterval = 10
        
        
        inTime.inputView = inTimePicker
        outTime.inputView = outTimePicker
        
        
        toolbar.setItems([doneButton], animated: true)
        inTime.inputAccessoryView = toolbar
        outTime.inputAccessoryView = toolbar
        
        
        
        
        
        
        
        
        //
        w_type.inputView = weightPicker
        
        let weighttoolbar = UIToolbar()
        weighttoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let weightdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(AddDivingRecordViewController.doneClicked))
        weighttoolbar.setItems([weightdone], animated: true)
        w_type.inputAccessoryView = weighttoolbar
        
        
        //
        permeability_typ.inputView = transparencyPicker
        
        let permeability_typtoolbar = UIToolbar()
        permeability_typtoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let permeability_typdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(AddDivingRecordViewController.doneClicked))
        permeability_typtoolbar.setItems([permeability_typdone], animated: true)
        permeability_typ.inputAccessoryView = permeability_typtoolbar
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @objc func doneClicked(picker: UIPickerView){
        let dateFormatter = DateFormatter()
        
        
        // 持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        // textFieldに選択した日付を代入
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        
        
        
        
        let formartter = DateFormatter()
        formartter.dateFormat = "hh:mm"
        
        if inTime.isFirstResponder{
            
            inTime.text = "\(formartter.string(from: inTimePicker.date))"
            
        }else if outTime.isFirstResponder{
            
            outTime.text = "\(formartter.string(from: outTimePicker.date))"
            
        }
        
        
        // キーボードを閉じる
        self.view.endEditing(true)
        
        
        
    }
    
    
    
    //
    @objc func dateChange(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        inTime.text = "\(formatter.string(from: inTimePicker.date))"
        outTime.text = "\(formatter.string(from: outTimePicker.date))"
        
    }
    
    
    
    
    
    //ピッカーの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //ピッカーの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == transparencyPicker {
            
            return tspy_type.count
            
        } else if pickerView == weightPicker {
            
            return type.count
            
        }
        return 0
    }
    
    
    
    // UIPickerViewに表示する配列
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if picker == transparencyPicker {
            return tspy_type[row] as String
            
        }else if picker == weightPicker {
            
            return type[row] as String
            
        }
        
        return ""
    }
    
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if picker == transparencyPicker {
            permeability_typ.text = tspy_type[row]
            
        }else if picker == weightPicker{
            w_type.text = type[row]
            
        }
        
        
    }
    
    
    
    
    
    
    @IBAction func finish(_ sender: Any) {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy月MM日dd"
        
        let db = Firestore.firestore()
        db.collection("DivingRecord").document().setData([
            "createTime":Date().timeIntervalSince1970,
            "createTime_02":df.string(from: Date()),
            "divingGroundTitle":divingGroundTitle.text! as String,
            "dateTextField":dateTextField.text! as String,
            "inTime":inTime.text! as String,
            "outTime":outTime.text! as String,
            "startingPressure":startingPressure.text! as String,
            "endPressure":endPressure.text! as String,
            "airTemperature":airTemperature.text! as String,
            "waterTemperature":waterTemperature.text! as String,
            "transparency":transparency.text! as String,
            "transparency_type":permeability_typ.text! as String,
            "weight":weight.text! as String,
            "weight_type":w_type.text! as String,
            "comment":commentTextViewObj.text! as String,
            "user":Auth.auth().currentUser?.uid as Any,
            "title":divingGroundTitle.text! as String
            
            
        ])
        
        diviingSetValue?.diviingValue(set: divingRecordModel )
        
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let dateFormatter = DateFormatter()
        let date2 = dateFormatter.date(from: inTime.text!)
        
        
        return true
    }
    
    //テキストビューの編集が開始されたら
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    //テキストビューの編集が終了したら
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "コメント"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

