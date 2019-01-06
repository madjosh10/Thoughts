//
//  ThoughtCell.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/26/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

protocol ThoughtDelegate {
    func thoughtOptionsTapped(thought: Thought)
    
}

class ThoughtCell: UITableViewCell {
   
    // IBOutlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumberLbl: UILabel!
    @IBOutlet weak var commentsNumLbl: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    // Variables
    private var thought: Thought!
    private var delegate : ThoughtDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
        
    }
    
    @objc func likeTapped() {
        Firestore.firestore().document("thoughts/\(thought.documentId!)").updateData([NUM_LIKE : thought.numLikes + 1])
        
    }
    
    func configureCell(thought: Thought, delegate: ThoughtDelegate) {
        optionsMenu.isHidden = true
        self.thought = thought
        self.delegate = delegate
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtText
        likesNumberLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)

        timestampLbl.text = timestamp
        
        if thought.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
        
        
    } // end configureCell()
    
    @objc func thoughtOptionsTapped() {
        delegate.thoughtOptionsTapped(thought: thought)
        
    }
    
    
    
    
    


}
