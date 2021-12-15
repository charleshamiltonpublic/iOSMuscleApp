//
//  WorkoutDetailViewController.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 11/29/21.
//

import UIKit
import Firebase
import GoogleSignIn

class WorkoutDetailViewController: UIViewController {
    
    //MARK: Attributes
    //var taskID: String = ""
    var workoutID: String = ""
    //var task: appTask?
    var workout: appWorkout?
    //var muscle: appMuscle?
    //private var service: TaskService?
    private var workoutservice: WorkoutService?
    //private var muscleservice: MuscleService?
    
//    private var allexercises = [appMuscle]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.exercises = self.allexercises
//            }
//        }
//    }
//
//    var exercises = [appMuscle]() {
//        didSet {
//            DispatchQueue.main.async {
//                //self.view.reloadInputViews()
//                //self.tableView.reloadData()
//            }
//        }
//    }
    // MARK: IBOutlets and Actions
    //@IBOutlet var lblTaskData: UILabel!
    @IBOutlet var lblWorkoutData: UILabel!
    //@IBOutlet var lblDueDate: UILabel!
    @IBOutlet var lblCompleteDate: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var imgbody: UIImageView!
    
    @IBOutlet var lblMuscle1: UILabel!
    @IBOutlet var lblMuscle2: UILabel!
    @IBOutlet var lblMuscle3: UILabel!
    
    @IBOutlet var lblExercise1: UILabel!
    @IBOutlet var lblExercise2: UILabel!
    @IBOutlet var lblExercise3: UILabel!

//    @IBOutlet var switchCompleted: UISwitch!
    
//    @IBAction func switchOnValueChanged(_ sender: Any){
//        let db = Firestore.firestore()
//        //var completed: Bool = false
//        var incomplete: Bool = false
//        if switchCompleted.isOn {
//            incomplete = true
//            print("The switch is on; the task is completed")
//        } else {
//            incomplete = false
//            print("The switch is off; the task is NOT completed")
//        }
//
//        // Get a reference to our Firestore document
//        //let taskRef: DocumentReference? = db.collection("tasks").document(self.taskID)
//        let workoutRef: DocumentReference? = db.collection("workouts").document(self.workoutID)
//        //taskRef?.updateData(["completed": completed]) { err in
//        workoutRef?.updateData(["incomplete": incomplete]) { err in
//            if let error = err {
//                print("Error updating document: \(error)")
//            } else {
//                print("Document \(workoutRef!.documentID) updated!")
//                //print("Document \(taskRef!.documentID) updated!")
//            }
//        }
//
//        //Dismiss this view
//        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
//    }
    
    //MARK: Custom methods
    func loadData() {
        //service = TaskService()
        workoutservice = WorkoutService()
        //muscleservice = MuscleService()
        var collection = ""
        var category = ""
        if let user = GIDSignIn.sharedInstance.currentUser {
            collection = user.userID!
            //collection = "workouts"
        }
        //service?.getOne(collectionID: collection, taskID: taskID) { task in
        workoutservice?.getOne(collectionID: collection, workoutID: workoutID) { workout in
            self.workout = workout
            //self.task = task
            //self.lblTaskData.text = self.task?.taskdata
            self.lblWorkoutData.text = self.workout?.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            //self.lblDueDate.text = dateFormatter.string(from: self.task?.duedate as! Date)
            self.lblCompleteDate.text = dateFormatter.string(from: self.workout?.createdate as! Date)
            //if self.task?.completed == false {
//            if self.workout?.incomplete == false {
//                self.switchCompleted.setOn(false, animated: false)
//            } else {
//                self.switchCompleted.setOn(true, animated: true)
//            }
            category = self.workout?.category ?? ""
            if category == "shoulders" {
                self.imgbody.image=UIImage(named: "shoulderImage")
            } else if category == "chest" {
                self.imgbody.image=UIImage(named: "chestImage")
            } else if category == "legs" {
                self.imgbody.image=UIImage(named: "legsImage")
            } else if category == "back" {
                self.imgbody.image=UIImage(named: "backImage")
            } else {
                self.imgbody.image=UIImage(named: "armsImage")
            }
            self.lblCategory.text = category
            self.lblExercise1.text = self.workout?.exercises?[0]
            self.lblExercise2.text = self.workout?.exercises?[1]
            self.lblExercise3.text = self.workout?.exercises?[2]
            
            self.lblMuscle1.text = self.workout?.muscles?[0]
            self.lblMuscle2.text = self.workout?.muscles?[1]
            self.lblMuscle3.text = self.workout?.muscles?[2]
            
            
        }
        //category = self.workout?.category ?? ""
        //muscleservice?.get(collectionID: "muscles", groupID: category) {_ in
//            exercises in
//            self.allexercises = exercises
//            self.lblMuscle1.text = self.allexercises[0].muscleID ?? ""
//            self.lblMuscle2.text = self.allexercises[1].muscleID ?? ""
//            self.lblMuscle3.text = self.allexercises[2].muscleID ?? ""
        //}
//        muscleservice?.getOne(collectionID: "muscles", groupID: "shoulders", muscleID: "anterior delts") { muscle in
//            self.muscle = muscle
//            //print(self.muscle?.muscleID)
//            //print(self.muscle?.exercises)
//        }
    }
    
    //MARK: Lifecycle functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(taskID)
        print(workoutID)
        loadData()
    }
    
}

