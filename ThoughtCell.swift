//
//  ThoughtCell.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/26/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {
   
    // IBOutlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumberLbl: UILabel!
    @IBOutlet weak var commentsNumLbl: UILabel!
    
    // Variables
    private var thought: Thought!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
        
    }
    
    @objc func likeTapped() {
        // Method 1
//        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId)
//            .setData([NUM_LIKE : thought.numLikes + 1], merge: true)
        // Method 2
        Firestore.firestore().document("thoughts/\(thought.documentId!)").updateData([NUM_LIKE : thought.numLikes + 1])
    }
    
    func configureCell(thought: Thought) {
        self.thought = thought
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtText
        likesNumberLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)

        timestampLbl.text = timestamp
        
        
    }


}
