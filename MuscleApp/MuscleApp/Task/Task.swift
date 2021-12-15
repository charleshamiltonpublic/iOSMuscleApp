
//
//  Task.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/11/21.
//

import UIKit
import Firebase

struct appTask {
    let taskID: String?
    let taskdata: String?
    let duedate: Date?
    let completed: Bool?
}

extension appTask {
    // Turn a collection of documents from Firestore into an array of appTasks
    static func build(from documents: [QueryDocumentSnapshot]) -> [appTask] {
        var tasks = [appTask]()
                    
        
        for document in documents {
            let stamp = document["duedate"] as? Timestamp
            var duedate: Date
            if let dd = stamp {
                duedate = dd.dateValue()
            } else {
                // If no due date, set it to today
                duedate = Date()
            }
            tasks.append(appTask(taskID: document.documentID,
                                 taskdata: document["taskdata"] as? String ?? "",
                                 duedate: duedate,
                                 completed: document["completed"] as? Bool))
        }
        
        return tasks
    }
    
    static func buildOne(from document: DocumentSnapshot) -> appTask {
        let stamp = document["duedate"] as? Timestamp
        var duedate: Date
        if let dd = stamp {
            duedate = dd.dateValue()
        } else {
            // If no due date, set it to today
            duedate = Date()
        }
        
        return appTask(taskID: document.documentID,
                       taskdata: document["taskdata"] as? String ?? "",
                       duedate: duedate,
                       completed: document["completed"] as? Bool)
    }
}

