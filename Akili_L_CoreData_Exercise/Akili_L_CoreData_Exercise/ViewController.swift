//
//  ViewController.swift
//  Akili_L_CoreData_Exercise
//
//  Created by Akili London on 8/12/20.
//  Copyright © 2020 Akili London. All rights reserved.
//


import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    

    // 12. Create the dataManager variable and listArry variable.
    // SCROLL DOWN TO THE viewDidLoad Function TO COMPLETE STEP 13
    //
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    // 15. Enter the saveRecordButton function below
    //
    @IBAction func saveRecordButton(_ sender: UIButton) {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
        newEntity.setValue(enterPositiveMessage.text!, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch{
            print ("Error saving data")
        }
        displayDataHere.text?.removeAll()
        enterPositiveMessage.text?.removeAll()
        fetchData()
        

        
    }
    
    // 16. Enter the deleteRecordButton function below
    // Yeah! you are done now build and run your code!
    //
    @IBAction func deleteRecordButton(_ sender: UIButton) {
        let deleteItem = enterPositiveMessage.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print ("Error deleting data")
            }
            displayDataHere.text?.removeAll()
            enterPositiveMessage.text?.removeAll()
            fetchData()
        }
        
    }
    
    
    
    @IBOutlet var enterPositiveMessage: UITextField!
    
    
    
    @IBOutlet var displayDataHere: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 13. Add the constant appDelegate to the viewDidLoad function
//        //
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        dataManager = appDelegate.persistentContainer.viewContext
//        displayDataHere.text?.removeAll()
//        fetchData()
    }
    
    
        // 14. Enter the fetchData function below.
        // GO BACK UP TO THE SAVE RECORD BUTTON FUNCTION TO COMPLETE STEP 15
    func fetchData() {
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                displayDataHere.text! += product

            }
        } catch {
            print ("Error retrieving data")
        }
    }



}
