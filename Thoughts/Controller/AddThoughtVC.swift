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
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var thoughtText: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    // Variables
    private var selectedCategory = "funny"
    
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
        
        
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
        Firestore.firestore().collection("thoughts").addDocument(data: [
            "category" : selectedCategory,
            "numComments" : 0,
            "numLikes" : 0,
            "thoughtText": thoughtText.text,
            "timestamp" : FieldValue.serverTimestamp(),
            "username" : userNameTxt.text!
            
            ]) { (err) in
                if let err = err {
                    debugPrint("Error adding document: \(err)")
                    
                } else {
                    self.navigationController?.popViewController(animated: true)
                    
                }
        }
        
        
    }
    
    

} // end AddThoughtVC class
