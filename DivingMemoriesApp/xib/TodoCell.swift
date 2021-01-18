//
//  TodoCell.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/25.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var taitleLabel: UILabel!
    
    @IBOutlet var budgetLabel: UILabel!
    
    @IBOutlet var numberOfPeopleLabel: UILabel!
    
    @IBOutlet var dutchTreatLabel: UILabel!
    
    @IBOutlet var memoLabel: UITextView!
    
    @IBOutlet var peopletext: UILabel!
    
    @IBOutlet var memoLabeObj: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        memoLabel.layer.cornerRadius = 5
        memoLabel.clipsToBounds = true
        
        memoLabeObj.layer.cornerRadius = 5
        memoLabeObj.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
