//
//  ViewController.swift
//  Calculator
//
//  Created by Adam Moore on 6/18/18.
//  Copyright © 2018 Adam Moore. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var firstNumber = String()
    var secondNumber = String()
    var operationSelected = false
    var savedMemoryItems = [Memory]()
    
    @IBOutlet weak var equationLabel: UILabel!
    
    func resetFirstNumber() {
        
        firstNumber = "0"
        
    }
    
    func updateEquationLabel() {
        
        if operationSelected == false {
            
            equationLabel.text = firstNumber
            
        } else {
            
            equationLabel.text = secondNumber
            
        }
        
    }
    
    func loadedSavedNumberArray() -> [Memory] {
        
        var loadedNumbers = [Memory]()
        
        let request: NSFetchRequest<Memory> = Memory.fetchRequest()
        
        do {
            
            loadedNumbers = try context.fetch(request)
            
        } catch {
            
            print("Could not load saved number: \(error)")
            
        }
        
        return loadedNumbers
        
    }
    

    
    @IBAction func reset(_ sender: UIButton) {
    }
    
    @IBAction func clear(_ sender: UIButton) {
        resetFirstNumber()
        operationSelected = false
        updateEquationLabel()
    }
    
    @IBAction func del(_ sender: UIButton) {
    }
    
    @IBAction func memory(_ sender: UIButton) {
        
        savedMemoryItems = loadedSavedNumberArray()
        
        if !savedMemoryItems.isEmpty {
            
            firstNumber = String(savedMemoryItems[0].savedMemoryItem)
            updateEquationLabel()
            
        } else {
            
            resetFirstNumber()
            updateEquationLabel()
            
        }
        
    }
    
    @IBAction func memoryAdd(_ sender: UIButton) {
        
        savedMemoryItems = loadedSavedNumberArray()
        
        if savedMemoryItems.isEmpty {
            
            let newMemoryItem = Memory(context: context)
            newMemoryItem.savedMemoryItem = Double(firstNumber) ?? 0
            
        } else {
            
            savedMemoryItems[0].savedMemoryItem = Double(firstNumber) ?? 0

        }
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error)
            
        }
        
    }
    
    @IBAction func memoryClear(_ sender: UIButton) {
        
        savedMemoryItems = loadedSavedNumberArray()
        
        savedMemoryItems[0].savedMemoryItem = 0
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error)
            
        }
        
        resetFirstNumber()
        updateEquationLabel()
        
    }
    
    @IBAction func add(_ sender: UIButton) {
    }
    
    @IBAction func subtract(_ sender: UIButton) {
    }
    
    @IBAction func multiply(_ sender: UIButton) {
    }
    
    @IBAction func divide(_ sender: UIButton) {
    }
    
    @IBAction func decimal(_ sender: UIButton) {
    }
    
    @IBAction func equals(_ sender: UIButton) {
    }
    
    @IBAction func number(_ sender: UIButton) {
        
        if firstNumber == "0" {
            
            firstNumber = ""
            
        }
        
        firstNumber += "\(sender.tag)"
        updateEquationLabel()
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetFirstNumber()
        equationLabel.text = firstNumber
        
        savedMemoryItems = loadedSavedNumberArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

