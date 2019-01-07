//
//  UpdateCommentVC.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 1/7/19.
//  Copyright © 2019 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var updateBtn: RoundButton!
    
    //variables
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentText.layer.cornerRadius = 10
        commentText.text = commentData.comment.commentText
        
    }
    

    @IBAction func updateBtnClicked(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
            .collection(COMMENTS_REF).document(commentData.comment.documentId).updateData([COMMENT_TXT : commentText.text]) { (error) in
                if let error = error {
                    debugPrint("Unable to update Comment: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        
    }
    
    
    
    
} // end UpdateCommentsVC class
