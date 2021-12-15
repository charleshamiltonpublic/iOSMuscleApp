//
//  MuscleGroup.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/14/21.
//

import UIKit
import Firebase

struct appGroup {
    let groupID: String?
    //let name: String?
    //let musclegroup: [String]?
}
//https://stackoverflow.com/questions/47514419/how-to-add-subcollection-to-a-document-in-firebase-cloud-firestore/47517402
//https://www.freetrainers.com/exercise/muscle/anterior_delts
//DocumentReference messageRef = db
//.collection("rooms").document("roomA")
//.collection("messages").document("message1");
extension appGroup {
    // Turn a collection of documents from Firestore into an array of appWorkouts
    static func build(from documents: [QueryDocumentSnapshot]) -> [appGroup] {
        var group = [appGroup]()
                    
        
        for document in documents {
//            let stamp = document["createdate"] as? Timestamp
//            var dater: Date
//            if let dd = stamp {
//                dater = dd.dateValue()
//            } else {
//                // If no due date, set it to today
//                dater = Date()
//            }
//            musclegroup.append(appGroup(workoutID: document.documentID,
//                                   name: document["name"] as? String ?? "",
//                                 category: document["category"] as? String ?? "",
//                                 exercises: document["exercises"] as? [String] ?? [],
//                                 createdate: dater,
//                                 incomplete: document["incomplete"] as? Bool))
//        }
            group.append(appGroup(groupID: document.documentID))
                                  //name: document["name"] as? String ?? ""))
        }
        
        return group
    }
    
    static func buildOne(from document: DocumentSnapshot) -> appGroup {
//        let stamp = document["createdate"] as? Timestamp
//        var dater: Date
//        if let dd = stamp {
//            dater = dd.dateValue()
//        } else {
//            // If no due date, set it to today
//            dater = Date()
//        }
        
//        return appGroup(workoutID: document.documentID,
//                          name: document["name"] as? String ?? "",
//                          category: document["category"] as? String ?? "",
//                          exercises: document["exercises"] as? [String] ?? [],
//                          createdate: dater,
//                          incomplete: document["incomplete"] as? Bool)
        return appGroup(groupID: document.documentID)
                        //name: document["name"] as? String ?? "")
    }
    
    
}


