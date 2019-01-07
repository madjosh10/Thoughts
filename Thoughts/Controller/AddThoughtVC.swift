//
//  AddThoughtVC.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/26/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
    // IBOutlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var thoughtText: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postBtn.layer.cornerRadius = 4
        thoughtText.layer.cornerRadius = 4
        thoughtText.text = "My Random Thought.."
        thoughtText.textColor = UIColor.lightGray
        
        //declare delegate
        thoughtText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
        
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
            case 0:
                selectedCategory = ThoughtCategory.funny.rawValue
            case 1:
                selectedCategory = ThoughtCategory.serious.rawValue
            default:
                selectedCategory = ThoughtCategory.crazy.rawValue
        }
        
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
        
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKE : 0,
            THOUGHT_TXT: thoughtText.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : Auth.auth().currentUser?.displayName ?? "",
            USER_ID: Auth.auth().currentUser?.uid ?? ""
            
            ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
                    
            } else {
                self.navigationController?.popViewController(animated: true)
                    
            }
        }
        
        
    }
    
    

} // end AddThoughtVC class
