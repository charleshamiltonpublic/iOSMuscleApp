//
//  WorkoutExerciseSelectViewController.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/11/21.
//

import UIKit
import Firebase
import GoogleSignIn

class WorkoutExerciseSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Attributes
    let db = Firestore.firestore()
    
    var muscleLabeldata1: String = ""
    var muscleLabeldata2: String = ""
    var muscleLabeldata3: String = ""
    var exercisedata1: [String] = []
    var exercisedata2: [String] = []
    var exercisedata3: [String] = []
    
    var selectCategory: String = ""
    
    var totalExercises: [String] = []
    
//    var muscle: appMuscle?
//
//    private var muscleservice: MuscleService?
//
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
//                //self.tableView.reloadData()
//            }
//        }
//    }
    
    //var incomplete: Bool = false
    
    // MARK: IBOutlets and Actions
    @IBOutlet var categoryLabel: UILabel!
    
    @IBOutlet var txtName: UITextField!
    
    //@IBOutlet var txtExercise: UITextField!
    
    @IBOutlet var muscleLabel1: UILabel!
    @IBOutlet var muscleLabel2: UILabel!
    @IBOutlet var muscleLabel3: UILabel!
    
    @IBOutlet var exercisePicker: UIPickerView!
    
    //@IBOutlet var txtTask: UITextField!
    
//    @IBAction func btnAdd(_ sender: UIButton) {
//        if let te = txtExercise.text {
//            totalExercises.append(te)
//            self.txtExercise.text = ""
//        } else {
//            print("Exercise not added!")
//        }
//    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        //var taskdata: String = ""
        var namedata: String = ""
        
        //let completed: Bool = false
        
        //if let td = txtTask.text {
        if let nd = txtName.text {
            //taskdata = td
            namedata = nd
        }
        
        
        // Add a document to the collection named "tasks"
        var ref: DocumentReference? = nil
        
        var collection = ""
        if let user = GIDSignIn.sharedInstance.currentUser {
            collection = user.userID!
            //collection = "workouts"
        }
        totalExercises.append(exercisedata1[exercisePicker.selectedRow(inComponent: 0)])
        totalExercises.append(exercisedata2[exercisePicker.selectedRow(inComponent: 1)])
        totalExercises.append(exercisedata3[exercisePicker.selectedRow(inComponent: 2)])
        
        ref = db.collection(collection).addDocument(data: [
//            "taskdata": taskdata,
//            "duedate": dueDate.date,
//            "completed": completed
            "name": namedata,
            "category": selectCategory,
            "createdate": Date(),
            "exercises": totalExercises,
            "muscles": [muscleLabeldata1, muscleLabeldata2, muscleLabeldata3]
            //"incomplete": incomplete,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)!")
            }
        }
        
        // Dismiss the view controller
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return exercisedata1.count
        }
        else if component == 1 {
            return exercisedata2.count
        } else {
            return exercisedata3.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return exercisedata1[row]
        }
        else if component == 1 {
            return exercisedata2[row]
        }
        else {
            return exercisedata3[row]
        }
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        exercisePicker.delegate = self
        exercisePicker.dataSource = self
        exercisePicker.reloadAllComponents()
    }
    //MARK: Custom methods
    func loadData() {
        self.categoryLabel.text = selectCategory
        self.muscleLabel1.text = muscleLabeldata1
        self.muscleLabel2.text = muscleLabeldata2
        self.muscleLabel3.text = muscleLabeldata3
        
        //muscleservice = MuscleService()
        
//        muscleservice?.getOne(collectionID: "muscles", groupID: "shoulders", muscleID: "anterior delts") { muscle in
//            self.muscle = muscle
//            print(self.muscle?.muscleID)
//            print(self.muscle?.exercises)
//        }
//        muscleservice?.get(collectionID: "muscles", groupID: selectCategory) {
//            exercises in
//            self.allexercises = exercises
//            print(self.allexercises[0].exercises)
//            self.exercisedata1 = self.allexercises[0].exercises ?? []
//            self.exercisedata2 = self.allexercises[1].exercises ?? []
//            self.exercisedata3 = self.allexercises[2].exercises ?? []
        //}
    }
    //MARK: Lifecycle functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(selectCategory)
        loadData()
    }


}
//extension WorkoutExerciseSelectViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3;
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        print(exercisedata1.count)
//        return exercisedata1.count
//    }
//}
//extension WorkoutExerciseSelectViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        print(exercisedata1[row])
//        return exercisedata1[row]
//    }
//    // Capture the picker view selection
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // This method is triggered whenever the user makes a change to the picker selection.
//        // The parameter named row and component represents what was selected.
//    }
//}
