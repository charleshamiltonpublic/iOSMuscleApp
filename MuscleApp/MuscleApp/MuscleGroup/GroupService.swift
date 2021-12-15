//
//  GroupService.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/14/21.
//


import Foundation
import Firebase

class GroupService {
    let database = Firestore.firestore()
    
    func get(collectionID: String, handler: @escaping ([appGroup]) -> Void) {
        database.collection(collectionID)
            .addSnapshotListener {
                querySnapshot, err in
                if let error = err {
                    print(error)
                    handler([])
                } else {
                    handler(appGroup.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
    func getOne(collectionID: String, muscleID: String, handler: @escaping (appGroup) -> Void) {
        database.collection(collectionID).document(muscleID).addSnapshotListener {
            DocumentSnapshot, err in
            if let error = err {
                print(error)
            } else {
                handler(appGroup.buildOne(from: DocumentSnapshot!))
            }
        }
    }
}


