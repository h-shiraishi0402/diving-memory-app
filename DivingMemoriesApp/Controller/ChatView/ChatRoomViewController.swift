//
//  ChatRoomViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ChatRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    /*?
     
     ここの画面構成はどうしよう・・・・
     ルームのみか・・・課金でルーム作成できるようにするか・・・
     */
    
    
    @IBOutlet weak var ChatRoom: UITableView!
    
    
    var RoomName = ["test"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ChatRoom.delegate = self
        ChatRoom.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomName.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let RoomViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        RoomViewCell.textLabel?.text = RoomName[indexPath.row]
        
        
        return RoomViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.height / 6
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

            performSegue(withIdentifier: "CHAT", sender: nil)
           
 
        
    }
        
        
        
        
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    
}
