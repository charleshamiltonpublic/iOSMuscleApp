//
//  WorkoutTableViewController.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 11/29/21.
//

import UIKit
import Firebase
import GoogleSignIn

class WorkoutTableViewController: UITableViewController {
    
    // MARK: Attributes
    //private var service: TaskService?
    private var service: WorkoutService?
    
    //private var alltasks = [appTask]() {
    private var allworkouts = [appWorkout]() {
        didSet {
            DispatchQueue.main.async {
                //self.tasks = self.alltasks
                self.workouts = self.allworkouts
            }
        }
    }
    
    //var tasks = [appTask]() {
    var workouts = [appWorkout]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Custom methods
    
    func loadData() {
        //service = TaskService()
        service = WorkoutService()
        var collection = ""
        if let user = GIDSignIn.sharedInstance.currentUser {
            collection = user.userID!
            //collection = "workouts"
        }
        service?.get(collectionID: collection) {
            workouts in
            self.allworkouts = workouts
            //tasks in
            //self.alltasks = tasks
        }
    }

    
    // MARK: Event Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        // Load our data from Firestore
        loadData()
    }
    
    // MARK: Table View Controller required methods (2 of them)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tasks.count
        return workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        //var duedate: Date?
        var createdate: Date?
        //duedate = tasks[indexPath.row].duedate
        createdate = workouts[indexPath.row].createdate
        //cell.textLabel?.text = tasks[indexPath.row].taskdata
        cell.textLabel?.text = workouts[indexPath.row].name
        //if (duedate != nil){
        if (createdate != nil){
        //cell.detailTextLabel?.text = df.string(from: duedate as! Date)
            cell.detailTextLabel?.text = df.string(from: createdate as! Date)
        }
        return cell
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutDetailSegue" {
            //Get a reference to the destination view controller
            let detailView = segue.destination as! WorkoutDetailViewController
            
            //Figure out which table cell was clicked
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                //Get the string ID of the selected task
                //let taskID = tasks[indexPath.row].taskID!
                let workoutID = workouts[indexPath.row].workoutID!
                
                //Set the task ID on the destination view controller
                //detailView.taskID = taskID
                detailView.workoutID = workoutID
            }
        }
    }
//    func setVariableToPassBack () {
//        // Set up variables you want to pass back
//        performSegue(withIdentifier: "UnwindToTableVC1", sender: self)    }
    
}

