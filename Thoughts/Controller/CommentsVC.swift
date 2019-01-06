//
//  CommentsVC.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/30/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CommentDelegate {
    func commentOptionsTapped(comment: Comment) {
        // adding alert
        print(comment.username)
    }
    
    
    
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentText: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    
    //Variables
    var thought: Thought!
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!
    var commentListener : ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.documentId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
        
        self.view.bindToKeyboard()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentListener = firestore.collection(THOUGHTS_REF)
        .document(self.thought.documentId)
            .collection(COMMENTS_REF).addSnapshotListener({ (snapshot, error) in
                
                guard let snap = snapshot else {
                    debugPrint("Error Fetching Comments: \(error!)")
                    return
                }
                
                self.comments.removeAll()
                self.comments = Comment.parseData(snapshot: snap)
                self.tableView.reloadData()
            })
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }
    
    @IBAction func addCommentClicked(_ sender: Any) {
        guard let commentText = addCommentText.text else { return }
        
        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            do {
                try thoughtDocument = transaction.getDocument(self.firestore
                    .collection(THOUGHTS_REF)
                    .document(self.thought.documentId))
                
            } catch let error as NSError {
                debugPrint("Fetch Error: \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()?[NUM_COMMENTS] as? Int else { return nil }
            
            transaction.updateData([
                NUM_COMMENTS : oldNumComments + 1
                ], forDocument: self.thoughtRef)
            
            let newCommentRef = self.firestore.collection(THOUGHTS_REF)
            .document(self.thought.documentId)
            .collection(COMMENTS_REF)
            .document()
            
            transaction.setData([
                USERNAME : self.username,
                COMMENT_TXT : commentText,
                TIMESTAMP : FieldValue.serverTimestamp(),
                USER_ID: Auth.auth().currentUser?.uid ?? ""
                ], forDocument: newCommentRef)
            
            
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Transaction Failed: \(error)")
            } else {
                self.addCommentText.text = ""
                self.addCommentText.resignFirstResponder()
                
            }
        }
        
    } // end addCommentClicked()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell {
            cell.configureCell(comment: comments[indexPath.row], delegate: self)
            return cell
        }
        
        return UITableViewCell()
    }
    
    

} // end CommentsVC class
