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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let game = Game(context: context)
        game.title = titleTextfield.text
        game.image = UIImagePNGRepresentation(gameImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
