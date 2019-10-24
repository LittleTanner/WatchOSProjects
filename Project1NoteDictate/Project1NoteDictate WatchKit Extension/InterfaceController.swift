//
//  InterfaceController.swift
//  Project1NoteDictate WatchKit Extension
//
//  Created by Kevin Tanner on 10/23/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Outlets

    @IBOutlet weak var table: WKInterfaceTable!
    
    // MARK: - Properties

    var notes = [String]()
    var savePath = InterfaceController.getDocumentsDirectory().appendingPathComponent("notes")
    
    // MARK: - Lifecycle Methods

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        do {
            let data = try Data(contentsOf: savePath)
            notes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] ?? [String]()
        } catch {
            // do nothing; notes is already an empty array
        }
        
        table.setNumberOfRows(notes.count, withRowType: "Row")
        
        for rowIndex in 0 ..< notes.count {
            set(row: rowIndex, to: notes[rowIndex])
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Actions

    @IBAction func addNewNote() {
        // Request User Input
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { [unowned self] result in
            // Convert the returned item to a string if possible, otherwise bail out
            guard let result = result?.first as? String else { return }
            // Insert a new row at the end of our table
            self.table.insertRows(at: IndexSet(integer: self.notes.count), withRowType: "Row")
            // Give our new row the correct text
            self.set(row: self.notes.count, to: result)
            // Append the new note to our array
            self.notes.append(result)
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self.notes, requiringSecureCoding: false)
                try data.write(to: self.savePath)
            } catch {
                print("Failed to save data: \(error.localizedDescription).")
            }
        }
    }
    
    // MARK: - Custom Methods
    
    func set(row rowIndex: Int, to text: String) {
        guard let row = table.rowController(at: rowIndex) as? NoteSelectRow else { return }
        row.textLabel.setText(text)
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return ["index": String(rowIndex + 1), "note": notes[rowIndex]]
    }

    
    // MARK: - Persistence
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
