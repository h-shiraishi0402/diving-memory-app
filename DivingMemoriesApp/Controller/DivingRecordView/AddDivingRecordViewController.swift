//
//  AddDivingRecordViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/20.
//

import UIKit

class AddDivingRecordViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
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
    
    //潜水地
    @IBOutlet var divingGroundTitle: UITextView!
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
    ////ウェイトタイプ
    @IBOutlet var w_type: UITextField!
    
    
    var tspy_type = ["ft","m"]
    var type = ["lbs","kg"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        divingGroundTitle.layer.cornerRadius = 20
        divingGroundTitle.clipsToBounds = true
        dateTextField.delegate = self
        
        inTime.delegate = self
        
        outTime.delegate = self
        
        startingPressure.delegate = self
        
        endPressure.delegate = self
        
        airTemperature.delegate = self
        
        waterTemperature.delegate = self
        
        transparency.delegate = self
        
        weight.delegate = self
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        
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
        //        //
        //        OwnedLicenseCreat.inputView = OwnedLiicensePicker
        //
        //        let OwnedLiicensetoolbar = UIToolbar()
        //        OwnedLiicensetoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        //
        //        let OwnedLiicensePickerdone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        //        OwnedLiicensetoolbar.setItems([OwnedLiicensePickerdone], animated: true)
        //        OwnedLicenseCreat.inputAccessoryView = OwnedLiicensetoolbar
        //
        //
        //
        //        //
        //        DivinghistoryCreat.inputView = DivinghistoryPicker
        //
        //        let Divinghistorytoolbar = UIToolbar()
        //        Divinghistorytoolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        //
        //        let Divinghistorydone = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(SettingViewController.donePicker))
        //        Divinghistorytoolbar.setItems([Divinghistorydone], animated: true)
        //        DivinghistoryCreat.inputAccessoryView = Divinghistorytoolbar
        //
        //
        
        
        
        
        
        
        
        
        
        
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
        
        if pickerView == transparencyPicker{
            
            return tspy_type.count
        }else if pickerView == weightPicker{
            
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
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}

