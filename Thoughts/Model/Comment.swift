//
//  Comment.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/30/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import Foundation
import Firebase
class Comment {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentText: String!
    
    
    init(username: String, timestamp: Date, commentText: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentText = commentText
       
    }
    
    
    
    
//    class func parseData(snapshot: QuerySnapshot!) -> [Thought] {
////        var thoughts = [Thought]()
////
////        guard let snap = snapshot else { return thoughts }
////        for document in snap.documents {
////            let data = document.data()
////            let username = data[USERNAME] as? String ?? "Anonymous"
////            let timestamp = data[TIMESTAMP] as? Date ?? Date()
////            let thoughtText = data[THOUGHT_TXT] as? String ?? ""
////            let numLikes = data[NUM_LIKE] as? Int ?? 0
////            let numComments = data[NUM_COMMENTS] as? Int ?? 0
////            let documentId = document.documentID
////
////            let newThought = Thought(username: username, timestamp: timestamp, thoughtText: thoughtText, numLikes: numLikes, numComments: numComments, documentId: documentId)
////            thoughts.append(newThought)
////
////        }
////
////
////
////        return thoughts
//
//    }
    
    
    
}
