//
//  AddingANewAnimal.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-09-16.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import os.log

class AddingANewPet: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //The default value should be the one of the segment that is hightlited by default.
    var animalType = "Cat"
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var animalTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func animalTypeSegmentedControlFunc(_ sender: Any) {
        switch animalTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            animalType = "Cat"
        case 1:
            animalType = "Dog"
        default:
            animalType = "Cat"
        }
    }
    
    /*
     This value is either passed by `ChatTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new pet.
     */
    var chat: Chat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation titles to large
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        //CONSOLE INFO: view was loaded
        print("LOADED: AddingANewPetView")
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    ///Reactivate Save button and update the title of the view to name of the pet when user stops editing the pet's name
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    ///Disable the Save button while editing the pet's name
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let animal = animalType
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let saveChat = Chat(context: context) // Link Task & Context
        //CONSIDER: instead of using traser variables, maybe just using the value of the text field and co
        saveChat.name = name
        saveChat.animal = animal
        //FAILS: look up how to save an image as data
        saveChat.image = photo as? Data
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        
        // Set the chat to be passed to ChatListVC after the unwind segue.
        //chat = Chat
    }
    
    ///Exits the view when user presses on cancel button
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    ///Disables the save button if the animal has no name
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
