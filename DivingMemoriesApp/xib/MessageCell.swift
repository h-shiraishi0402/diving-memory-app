//
//  MessageCell.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/22.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    
//   @IBOutlet weak var backImage: UIView!
    
    @IBOutlet weak var label: UITextView!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var Messageimage: UIImageView!
    
    @IBOutlet weak var messageTextViewWidth: NSLayoutConstraint!
    //最初に呼ばれる
    override func awakeFromNib() {
        super.awakeFromNib()
    print("MessageCell_awakeFromNib_Start--------------------------------------")
        

    
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.sizeToFit()
        leftImageView.layer.cornerRadius = 25
        
        
        
        
        
        // Initialization code
    print("MessageCell_awakeFromNib_END--------------------------------------")
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
