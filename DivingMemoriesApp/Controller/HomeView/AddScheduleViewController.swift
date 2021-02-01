//
//  AddScheduleViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/28.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import PKHUD

protocol TodosetValue {func todosetValue(set:TodoModel)}

class AddScheduleViewController: UIViewController,UITextViewDelegate,UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var numberOfPeopleTextField: UITextField!
    @IBOutlet var budgetTextField: UITextField!
    @IBOutlet var dutchTreatTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var finishObj: UIButton!
    
    var selectDay = Int()
    var selectYear = Int()
    var selectMounth = Int()
    var todoModel = TodoModel()
    var todosetValue:TodosetValue?
    var date = Int()
    var db = Firestore.firestore()
    var numberFormart = NumberFormatter()
    //応急処置(firebaseのdocumentの設定 udf_count + id_count )
    var id_count = 0
    var udf_count = "id_count"
    //参加人数
    var numberOfPeople = Int()
    //予算
    var budget = Int()
    //割り勘金額
    var dutchTreat = Int()
    
    //------------↑↑↑↑↑Global variables↑↑↑↑------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let newId = UserDefaults.standard.integer(forKey: udf_count)
        id_count = newId
        print("newID*\(id_count)")
        
        
        numberFormart.numberStyle = .decimal
        numberFormart.locale = Locale(identifier: "ja_JP")
        
        dutchTreatTextField.delegate = self
        
        memoTextView.layer.cornerRadius = 5
        
        finishObj.layer.cornerRadius = 30
        finishObj.clipsToBounds = true
        dateLabel.text = String("\(selectYear)年\(selectMounth)月\(selectDay)日")
        numberOfPeopleTextField.keyboardType = .numberPad
        budgetTextField.keyboardType = .numberPad
        
        dutchTreatTextField.text = "0"
        dutchTreatTextField.isEnabled = false
        dutchTreatTextField.isSelected = false
        
    }
    //完了
    @IBAction func done(_ sender: Any) {
        //カウントのインクリメント
        id_count = id_count + 1
        //保存
        UserDefaults.standard.setValue(id_count, forKey: udf_count)
        print(id_count)
        //firebaseに値の作成
        db.collection("Todo").document("ADD_TODO\(id_count)").setData(
            ["date2":dateLabel.text!,
             "title":titleTextField.text!,
             "date":"\(selectYear)年\(selectMounth)月\(selectDay)日",
             "numberOfPeople":numberOfPeopleTextField.text!,
             "budget":budgetTextField.text!,
             "dutchTreat":dutchTreatTextField.text!,
             "memo":memoTextView.text!,
             "date3":Date().timeIntervalSince1970,
             "user":Auth.auth().currentUser?.uid as Any,
             "CreateDate":Data(),
             "docId":"ADD_TODO\(id_count)"
            ])
        //
        todosetValue?.todosetValue(set: todoModel)
        //戻る
        dismiss(animated: true, completion: nil)
    }
    //戻る
    @IBAction func back(_ sender: Any) {dismiss(animated: true, completion: nil)}
    //キーボード以外をタップしたら呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if budgetTextField.text != "" && numberOfPeopleTextField.text  != "" {
            if numberOfPeople <= 1 {
                
                numberOfPeople = Int(numberOfPeopleTextField.text!)!
                budget = Int(budgetTextField.text!)!
                let calculation = budget / numberOfPeople
                let calculationNum = NSNumber(value: calculation)
                let calculationString  = numberFormart.string(from: calculationNum)
                dutchTreatTextField.text = String(calculationString! )
            }else{
                let budgetValue = NSNumber(value: budget)
                let budgetString  = numberFormart.string(from: budgetValue)
                dutchTreatTextField.text = String(budgetString!)
            }
        }else{
            dutchTreatTextField.text = "0"
        }
    }
    //Returnをしたらキーボードが閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if budgetTextField.text != "" && budgetTextField.text  != "" {
            
            numberOfPeople = Int(numberOfPeopleTextField.text!)!
            budget = Int(budgetTextField.text!)!
            let calculation = budget / numberOfPeople
            let calculationNum = NSNumber(value: calculation)
            let calculationString  = numberFormart.string(from: calculationNum)
            dutchTreatTextField.text = String(calculationString! )
        }else{
            dutchTreatTextField.text = "0"
        }
        return true
    }
    
    
}
