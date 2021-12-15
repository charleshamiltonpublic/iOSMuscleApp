//
//  MuscleService.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/14/21.
//

import Foundation
import Firebase

class MuscleService {
    let database = Firestore.firestore()
    
    func get(collectionID: String, groupID: String, handler: @escaping ([appMuscle]) -> Void) {
        database.collection("musclegroups").document(groupID).collection(collectionID)
            .addSnapshotListener {
                querySnapshot, err in
                if let error = err {
                    print(error)
                    handler([])
                } else {
                    handler(appMuscle.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
    func getOne(collectionID: String, groupID: String, muscleID: String, handler: @escaping (appMuscle) -> Void) {
        database.collection("musclegroups").document(groupID).collection(collectionID).document(muscleID).addSnapshotListener {
            DocumentSnapshot, err in
            if let error = err {
                print(error)
            } else {
                handler(appMuscle.buildOne(from: DocumentSnapshot!))
            }
        }
    }
}

