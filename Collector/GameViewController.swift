//
//  GameViewController.swift
//  Collector
//
//  Created by Bradley Myhre on 2018-05-09.
//  Copyright © 2018 undergalaxie.com. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if game != nil {
            gameImageView.image = UIImage(data : game!.image as! Data)
            titleTextfield.text = game?.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if game != nil {
            game!.title = titleTextfield.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
            let game = Game(context: context)
            game.title = titleTextfield.text
            game.image = UIImagePNGRepresentation(gameImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
 
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
