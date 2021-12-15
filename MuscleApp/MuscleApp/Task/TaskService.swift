//
//  TaskService.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/11/21.
//

import Foundation
import Firebase

class TaskService {
    let database = Firestore.firestore()
    
    func get(collectionID: String, handler: @escaping ([appTask]) -> Void) {
        database.collection(collectionID)
            .addSnapshotListener {
                querySnapshot, err in
                if let error = err {
                    print(error)
                    handler([])
                } else {
                    handler(appTask.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
    func getOne(collectionID: String, taskID: String, handler: @escaping (appTask) -> Void) {
        database.collection(collectionID).document(taskID).addSnapshotListener {
            DocumentSnapshot, err in
            if let error = err {
                print(error)
            } else {
                handler(appTask.buildOne(from: DocumentSnapshot!))
            }
        }
    }
}

