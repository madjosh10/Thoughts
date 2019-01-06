//
//  CommentCell.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/30/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    func commentOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var timeStampText: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    // variables
    private var comment: Comment!
    private var delegate: CommentDelegate?
    
    
    func configureCell(comment: Comment, delegate: CommentDelegate?) {
        userNameText.text = comment.username
        commentText.text = comment.commentText
        optionsMenu.isHidden = true
        self.comment = comment
        self.delegate = delegate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timeStampText.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
        
    }
    
    @objc func commentOptionsTapped() {
        delegate?.commentOptionsTapped(comment: comment)
        
    }
    
    

  

}
