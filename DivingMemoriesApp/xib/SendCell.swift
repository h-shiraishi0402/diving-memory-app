//
//  SendCell.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/24.
//

import UIKit






class SendCell: UITableViewCell {
    
    

    @IBOutlet weak var SendLabel: UITextView!
    @IBOutlet weak var taimeLabel: UILabel!
    
    @IBOutlet weak var SendTextWidth: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
   print("SendCell_awakeFromNib_Star-----------------------------------------------------------------")
        

        //UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        

        //SendLabel.layer.cornerRadius = (SendLabel.frame.size.width * SendLabel.frame.size.height) / 2
        SendLabel.layer.cornerRadius = 5
        SendLabel.clipsToBounds = true
        SendLabel.sizeToFit()
        
        
    print("SendCell_awakeFromNib_End-----------------------------------------------------------------")
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
