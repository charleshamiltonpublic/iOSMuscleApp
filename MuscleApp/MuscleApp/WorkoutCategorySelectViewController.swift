//
//  WorkoutCategorySelectViewController.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 12/11/21.
//

import UIKit
import Firebase
import GoogleSignIn

class WorkoutCategorySelectViewController: UIViewController {
    
    // MARK: Attributes
    let db = Firestore.firestore()
    let data = ["arms", "back", "chest", "legs", "shoulders"]
    var catdata: String = ""
    var muscledata1: String = ""
    var muscledata2: String = ""
    var muscledata3: String = ""
    
    var muscle: appMuscle?
    var exercisedata1: [String] = []
    var exercisedata2: [String] = []
    var exercisedata3: [String] = []
    
    private var muscleservice: MuscleService?
    
    private var allexercises = [appMuscle]() {
        didSet {
            DispatchQueue.main.async {
                self.exercises = self.allexercises
            }
        }
    }
    
    var exercises = [appMuscle]() {
        didSet {
            DispatchQueue.main.async {
                //self.view.reloadInputViews()
                //self.tableView.reloadData()
            }
        }
    }
    
    // MARK: IBOutlets and Actions
    //@IBOutlet var txtTask: UITextField!
    
    //@IBOutlet var dueDate: UIDatePicker!
    
    @IBOutlet var categoryPicker: UIPickerView!
    
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        //var taskdata: String = ""
        
        //let completed: Bool = false
        
        //if let td = txtTask.text {
            //taskdata = td
        //}
        catdata = data[categoryPicker.selectedRow(inComponent: 0)]
        print(catdata)
        self.performSegue(withIdentifier: "workoutExerciseSegue", sender: self)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    //MARK: Segue
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if self.exercisedata3.count > 0 {
//        return true // always to next
//        }
//        return false // never to next
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutExerciseSegue" {
            muscleservice = MuscleService()
            muscleservice?.get(collectionID: "muscles", groupID: catdata) {
                exercises in
                self.allexercises = exercises
                //Get a reference to the destination view controller
                let selectView = segue.destination as! WorkoutExerciseSelectViewController
                selectView.muscleLabeldata1 = self.allexercises[0].muscleID ?? ""
                selectView.muscleLabeldata2 = self.allexercises[1].muscleID ?? ""
                selectView.muscleLabeldata3 = self.allexercises[2].muscleID ?? ""
                selectView.selectCategory = self.catdata
                selectView.exercisedata1 = self.allexercises[0].exercises ?? []
                selectView.exercisedata2 = self.allexercises[1].exercises ?? []
                selectView.exercisedata3 = self.allexercises[2].exercises ?? []
                self.exercisedata1 = self.allexercises[0].exercises ?? []
                self.exercisedata2 = self.allexercises[1].exercises ?? []
                self.exercisedata3 = self.allexercises[2].exercises ?? []
            }
        }
    }
    // MARK: Event Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }


}
extension WorkoutCategorySelectViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
extension WorkoutCategorySelectViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
}
