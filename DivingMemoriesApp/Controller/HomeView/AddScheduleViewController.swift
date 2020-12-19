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


protocol TodosetValue {
    func todosetValue(set:TodoModel)
}



class AddScheduleViewController: UIViewController,UITextViewDelegate,UIPickerViewDelegate, UITextFieldDelegate {
    
    
    var selectDay = Int()
    var selectYear = Int()
    var selectMounth = Int()
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var numberOfPeopleTextField: UITextField!
    @IBOutlet var budgetTextField: UITextField!
    @IBOutlet var dutchTreatTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var finishObj: UIButton!
    
    
    var numberOfPeoplePickerView = UIPickerView()
    var todoModel = TodoModel()
    var todosetValue:TodosetValue?
    var selectedDay = SelectDayViewController()
    var date = Int()
    var db = Firestore.firestore()
    var testTodo:TodoData?
    var numberFormart = NumberFormatter()
    
    
    //参加人数
    //var numberOfPeopleArray = ["1","2","3","4","5","6","7","8","9","10"]
    var numberOfPeople = Int()
    //予算
    var budget = Int()
    
    //割り勘金額
    var dutchTreat = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormart.numberStyle = .decimal
        numberFormart.locale = Locale(identifier: "ja_JP")
        
        dutchTreatTextField.delegate = self
        
        
        finishObj.layer.cornerRadius = 30
        finishObj.clipsToBounds = true
        dateLabel.text = String("\(selectYear)年\(selectMounth)月\(selectDay)日")
        numberOfPeopleTextField.keyboardType = .numberPad
        budgetTextField.keyboardType = .numberPad
        
        dutchTreatTextField.text = "0"
        dutchTreatTextField.isEnabled = false
        dutchTreatTextField.isSelected = false
        
    }
    

    @IBAction func done(_ sender: Any) {
        
        
        db.collection("Todo").document().setData(["date2":dateLabel.text!,"title":titleTextField.text!,"date":"\(selectYear)年\(selectMounth)月\(selectDay)日","numberOfPeople":numberOfPeopleTextField.text!,"budget":budgetTextField.text!,"dutchTreat":dutchTreatTextField.text!,"memo":memoTextView.text!,"date3":Date().timeIntervalSince1970,"user":Auth.auth().currentUser?.uid as Any,"CreateDate":Data()])
        
        
        todosetValue?.todosetValue(set: todoModel)
        
       
        dismiss(animated: true, completion: nil)
        
       
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
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
