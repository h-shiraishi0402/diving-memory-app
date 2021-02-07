//
//  ChatViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage
import AuthenticationServices
import UserNotifications

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height




class ChatViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    
    @IBOutlet weak var cahtTableView: UITableView!
    @IBOutlet weak var chatViewTextView: UITextView!
    @IBOutlet weak var formStack: UIStackView!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var sendButtonObj: UIButton!
    

    let db = Firestore.firestore()
    
    var roomName = String()
    var imageString = String()
    var messages:[Message] = []
    let dateFormatter = DateFormatter()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        //stuckViewを表示させる為に必要
        formStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //入力フォームのCorner
        chatViewTextView.layer.cornerRadius = 17
        
        cahtTableView.delegate = self
        cahtTableView.dataSource = self
        chatViewTextView.delegate = self
        
        
        //Cellの選択を不可にする
        cahtTableView.allowsSelection = false
        //TextViewで改行押すと挙動が変な時があるのを防ぐ
        chatViewTextView.layoutManager.allowsNonContiguousLayout = false
        
        
        //xib
        cahtTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Cell")
        cahtTableView.register(UINib(nibName: "SendCell", bundle: nil), forCellReuseIdentifier: "SendCell")
        
        
   
        
        
        if UserDefaults.standard.object(forKey: "userImage") != nil{
            
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
            
            
        }
        
        if roomName == ""{
            
            roomName = "ALL"
            
        }
        
        self.navigationItem.title = roomName
        
        loadMessages(roomName: roomName)
        
        // Do any additional setup after loading the view.
        print("chatViewConttroler_viewDidLoad_End---------------------")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("chatViewConttroler_viewWillAppear_Start---------------------")
        
        sendButtonObj.isEnabled = false
        print("chatViewConttroler_viewWillAppear_End---------------------")
    }
    
    //メッシー時のロード
    func loadMessages(roomName:String){
        
        db.collection(roomName).order(by: "date2").addSnapshotListener { (snapShot, error) in
            
            
            self.messages = []
            
            
            if error != nil{
                
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    if let sender = data["sender"] as? String,let body = data["body"] as? String,let imageString = data["imageString"] as? String,let date2 = data["date"] as? String{
                        
                        let newMessage = Message(sender: sender, body: body, date: date2, imageString: imageString)
                        self.messages.append(newMessage)
                        
                        
                        DispatchQueue.main.async {
                            self.cahtTableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.cahtTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
            
            
            
        }
        
        
    }
    

    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CellCount:\(messages.count)")
        return messages.count
    }
    
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //セル構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        let sendCell = tableView.dequeueReusableCell(withIdentifier: "SendCell", for: indexPath) as! SendCell
        let message = messages[indexPath.row]
       
        
        if message.sender == Auth.auth().currentUser?.uid{
            
            sendCell.SendLabel.text = message.body
            sendCell.taimeLabel.text = message.date
            let witdh = estimateFramefromTextView(text: message.body).width
            sendCell.SendTextWidth.constant = witdh + 20
            sendCell.SendLabel.backgroundColor = .systemTeal
            sendCell.SendLabel.textColor = .white
            sendCell.SendLabel.textAlignment = .left
            return sendCell
            
        }else{
            
            cell.label.text = message.body
            cell.rightLabel.text = message.date
            let witdh = estimateFramefromTextView(text: message.body).width
            cell.messageTextViewWidth.constant = witdh + 20
            //cell.leftImageView.isHidden = true
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            cell.label.backgroundColor = .orange
            cell.label.textColor = .white
            cell.label.textAlignment = .left
            
        }
        return cell
        
    }
    
    //textView内で何かしたら呼ばれる
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        sendButtonObj.isEnabled = true
        return true
    }
    
    //Fiewbaseに送信
    @IBAction func send(_ sender: Any) {
        print("chatViewConttroler_send(送信ボタン)_Start---------------------")
        
        
        
        if chatViewTextView.text != "" {
            
            if let messageBody = chatViewTextView.text,let sender = Auth.auth().currentUser?.uid{
                
                db.collection(roomName).addDocument(data: ["sender":sender,"body":messageBody,"imageString":imageString,"date":getToday(format: "MM月dd日 HH:mm"),"date2":getToday2(format: "yyyy年MM月dd日 HH:mm:ss")]) { (error) in
                    
                    if error != nil{
                        print("エラーに入ったよ")
                        print(error.debugDescription)
                        return
                        
                    }
                    
                    //非同期処理
                    DispatchQueue.main.async {
                        
                        self.chatViewTextView.text = ""
                        self.sendButtonObj.isEnabled = false
                        self.chatViewTextView.resignFirstResponder()
                        
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    //Fiewbaseよう_1
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    //Fiewbaseよう_2
    func getToday2(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now2 = Date()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = format
        return formatter2.string(from: now2 as Date)
    }
    
    //幅の設定可変
    func estimateFramefromTextView(text:String) -> CGRect{
        
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:14)], context: nil)
        
    }
    
    //戻るボタン
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //キーボードタッチで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        print("touchesBegan_START***********************")
        cahtTableView.reloadData()
        print("touchesBegan_END*************************")
    }
    
    
    
    
    
    
}
