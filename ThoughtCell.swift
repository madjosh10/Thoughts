//
//  ThoughtCell.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/26/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {
   
    // IBOutlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(thought: Thought) {
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtText
        likesNumberLbl.text = String(thought.numLikes)
    }


}
