//
//  HomeViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/21.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import Firebase
import FirebaseFirestore
import FirebaseAuth


let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class HomeViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITextViewDelegate,ProfileString{
    
    
    var settingViewController = SettingViewController()
    var selectDayViewController = SelectDayViewController()
    var todoValue = TodoModel()
    
    var nickname = String()
    var license = String()
    var selectDay = Int()
    var selectYear = Int()
    var selectMounth = Int()
    
    @IBOutlet weak var HomeViewCalender: FSCalendar!
    @IBOutlet var image: UIImageView!
    @IBOutlet var nikNmaeLabel: UILabel!
    @IBOutlet var licenseLabel: UILabel!
    @IBOutlet var HomeImage: UIImageView!
    
    
    //スケジュール内容
    let labelDate = UILabel(frame: CGRect(x: 5, y: 580, width: 400, height: 50))
    //「主なスケジュール」の表示
    let labelTitle = UILabel(frame: CGRect(x: 0, y: 530, width: 180, height: 50))
    //カレンダー部分
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 30, width: w, height: 400))
    //日付の表示
    let Date = UILabel(frame: CGRect(x: 5, y: 430, width: 200, height: 100))
    //グレコリオ歴
    let cld:Calendar = Calendar(identifier: .gregorian)
    
    var date:DateFormatter = {
        let d_formatter = DateFormatter()
        d_formatter.dateFormat = "yyyy-MM-dd"
        return d_formatter}()
    
    //------------↑↑↑↑↑Global variables↑↑↑↑------------------------------------------------
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendar()
        
        //ナビゲーションを非表示
        self.navigationController?.isNavigationBarHidden = true
        
        // タブについて（文字の選択時・未選択時の色・フォントを指定（フォントは最初に指定したものが優先される）)＞
        UITabBarItem.appearance().setTitleTextAttributes( [ .font :UIFont.init(name: "HelveticaNeue-Bold", size: 10) as Any,.foregroundColor : UIColor.blue ],for: .normal)
        
        
        // settingViewController.profileString = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        null_Judgment()
        
    }
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        
        let month = tmpCalendar.component(.month, from: date)
        
        let day = tmpCalendar.component(.day, from: date)
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        let year = tmpCalendar.component(.year, from: date)
        
        let month = tmpCalendar.component(.month, from: date)
        
        let day = tmpCalendar.component(.day, from: date)
        
        return (year,month,day)
        
    }
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        return tmpCalendar.component(.weekday, from: date)
        
    }
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            
            return UIColor.red
            
        }
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            
            return UIColor.red
        }
        
        else if weekday == 7 {  //土曜日
            return UIColor.blue
            
        }
        
        return nil
    }
    //日付タップ時の処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let selectedDate =  getDay(date)
        
        todoValue.date = "\(selectedDate)"
        
        selectYear = selectedDate.0
        
        selectMounth = selectedDate.1
        
        selectDay = selectedDate.2
        
        performSegue(withIdentifier: "TodoVc", sender: nil)
        
    }
    //カレンダーの設定
    func calendar(){
        HomeViewCalender.calendarWeekdayView.weekdayLabels[0].text = "日"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[1].text = "月"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[2].text = "火"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[3].text = "水"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[4].text = "木"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[5].text = "金"
        HomeViewCalender.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        HomeViewCalender.layer.cornerRadius = 20
        
        HomeViewCalender.clipsToBounds = true
        
        HomeViewCalender.delegate = self
        
        HomeViewCalender.dataSource = self
    }
    //セッティング画面に遷移（後ほど改名）
    @IBAction func transition_to_settingView(_ sender: Any) {}
    //セッティング画面で引っ張りたい値の為に
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を変数に入れる
        if segue.identifier == "Stetting" {
            
            let nextVC = segue.destination as! SettingViewController
            
            nextVC.profileString = self
            
        }else if segue.identifier == "TodoVc"{
            
            let TodoVc = segue.destination as! SelectDayViewController
            
            TodoVc.selectYear = selectYear
            
            TodoVc.selectMounth = selectMounth
            
            TodoVc.selectDay = selectDay
        }
    }
    //プロフィールの一部の値アをプリ内で保存
    func profileString(nicName:String,ownedLicense:String,image:Data)  {
        
        nikNmaeLabel.text = nicName
        
        licenseLabel.text = ownedLicense
        
        UserDefaults.standard.set(nicName, forKey: "nikNmaeLabel")
        
        UserDefaults.standard.set(ownedLicense, forKey: "licenseLabel")
        
        UserDefaults.standard.set(image, forKey: "image")
    }
    //空白判定
    func null_Judgment(){
        let nickname =  UserDefaults.standard.object(forKey: "nikNmaeLabel")
        
        let license = UserDefaults.standard.object(forKey: "licenseLabel")
        
        let imageData = UserDefaults.standard.data(forKey:"image")

        if nickname != nil{
            
            self.nikNmaeLabel.text = (nickname as! String)
            
            
        }else{
            
            self.nikNmaeLabel.text = .none
            
        }
        
        if license != nil{
            
            self.licenseLabel.text = (license as! String)
            
        }else{
            
            self.licenseLabel.text = .none
            
        }
        
        if imageData != nil  {
            
            image.image = UIImage(data: imageData!)
            
            image.layer.cornerRadius = image.frame.size.width * 0.5
            
            image.clipsToBounds = true
        }
    }
}
