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
    
    func commentOptionsTapped(comment: Comment) {
        // adding alert
        let alert = UIAlertController(title: "Edit Comment", message: "You can delete or edit this comment", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            // delete comment
//            self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId)
//                .collection(COMMENTS_REF).document(comment.documentId).delete(completion: { (error) in
//                    if let error = error {
//                        debugPrint("Unable to delete comment: \(error.localizedDescription)")
//                    } else {
//                        alert.dismiss(animated: true, completion: nil)
//                    }
//                })
            self.firestore.runTransaction({ (transaction, errorPointer) -> Any? in
                
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
                    NUM_COMMENTS : oldNumComments - 1
                    ], forDocument: self.thoughtRef)
                
                let commentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId)
                                .collection(COMMENTS_REF).document(comment.documentId)
                
               transaction.deleteDocument(commentRef)
                
                return nil
            }) { (object, error) in
                if let error = error {
                    debugPrint("Transaction Failed: \(error)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                    
                }
            }            
            
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            //edit comment
            self.performSegue(withIdentifier: "toEditComment", sender: (comment, self.thought))
            alert.dismiss(animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UpdateCommentVC {
            if let commentData = sender as? (comment: Comment, thought: Thought) {
                destination.commentData = commentData
            }
        }
    }
    
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
