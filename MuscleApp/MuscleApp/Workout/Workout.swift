//
//  Workout.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/12/21.
//

import UIKit
import Firebase

struct appWorkout {
    let workoutID: String?
    let name: String?
    let category: String?
    let exercises: [String]?
    let muscles: [String]?
    let createdate: Date?
    //let incomplete: Bool?
}
//https://stackoverflow.com/questions/47514419/how-to-add-subcollection-to-a-document-in-firebase-cloud-firestore/47517402
//https://www.freetrainers.com/exercise/muscle/anterior_delts
//DocumentReference messageRef = db
//.collection("rooms").document("roomA")
//.collection("messages").document("message1");
extension appWorkout {
    // Turn a collection of documents from Firestore into an array of appWorkouts
    static func build(from documents: [QueryDocumentSnapshot]) -> [appWorkout] {
        var work = [appWorkout]()
                    
        
        for document in documents {
            let stamp = document["createdate"] as? Timestamp
            var dater: Date
            if let dd = stamp {
                dater = dd.dateValue()
            } else {
                // If no due date, set it to today
                dater = Date()
            }
            work.append(appWorkout(workoutID: document.documentID,
                                   name: document["name"] as? String ?? "",
                                 category: document["category"] as? String ?? "",
                                 exercises: document["exercises"] as? [String] ?? [],
                                 muscles: document["muscles"] as? [String] ?? [],
                                 createdate: dater))
                                 //incomplete: document["incomplete"] as? Bool))
        }
        
        return work
    }
    
    static func buildOne(from document: DocumentSnapshot) -> appWorkout {
        let stamp = document["createdate"] as? Timestamp
        var dater: Date
        if let dd = stamp {
            dater = dd.dateValue()
        } else {
            // If no due date, set it to today
            dater = Date()
        }
        
        return appWorkout(workoutID: document.documentID,
                          name: document["name"] as? String ?? "",
                          category: document["category"] as? String ?? "",
                          exercises: document["exercises"] as? [String] ?? [],
                          muscles: document["muscles"] as? [String] ?? [],
                          createdate: dater)
                          //incomplete: document["incomplete"] as? Bool)
    }
}
