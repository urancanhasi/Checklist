//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Sebastien Arbogast on 29/08/2016.
//  Copyright © 2016 BusinessTraining. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller:AddItemViewController)
    func addItemViewController(controller:AddItemViewController, didFinishAddingItem:Checklist)
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem: Checklist)
}

class AddItemViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var addItemViewControllerDelegate: AddItemViewControllerDelegate?
    var checklistToEdit:Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklistToEdit = self.checklistToEdit {
            textField.text = checklistToEdit.title
            self.title = "Edit Item"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        doneButton.enabled = textField.text!.characters.count > 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        if let addItemViewControllerDelegate = self.addItemViewControllerDelegate {
            addItemViewControllerDelegate.addItemViewControllerDidCancel(self)
        }
    }
    
    @IBAction func save() {
        let title = self.textField.text
        
        let trimmedTitle = title?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if trimmedTitle?.characters.count == 0 {
            let alert = UIAlertController(title: "Erreur", message: "Le titre ne peut pas être vide", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            return
        } else {
            if let addItemViewControllerDelegate = self.addItemViewControllerDelegate {
                
                if let checklistToEdit = self.checklistToEdit {
                    checklistToEdit.title = trimmedTitle!
                    addItemViewControllerDelegate.addItemViewController(self, didFinishEditingItem: checklistToEdit)
                } else {
                    let checklist = Checklist(withTitle: trimmedTitle!)
                    addItemViewControllerDelegate.addItemViewController(self, didFinishAddingItem: checklist)
                }
            }
        }
    }
}

//UITableViewDelegate implementation
extension AddItemViewController {
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        
        let newText = (oldText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = newText.characters.count > 0
        
        return true
    }
}
