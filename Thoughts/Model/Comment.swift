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
    
    
    class func parseData(snapshot: QuerySnapshot!) -> [Comment] {
        var comments = [Comment]()

        guard let snap = snapshot else { return comments }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let commentText = data[COMMENT_TXT] as? String ?? ""
            

            let newComment = Comment(username: username, timestamp: timestamp, commentText: commentText)
            comments.append(newComment)
        }

        return comments

    }
    
    
    
}
