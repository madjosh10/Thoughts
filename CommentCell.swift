//
//  CommentCell.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/30/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var timeStampText: UILabel!
    
    
    func configureCell(comment: Comment) {
        userNameText.text = comment.username
        commentText.text = comment.commentText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timeStampText.text = timestamp
    }

  

}
