//
//  NoteEditViewController.swift
//  Internal3Demo
//
//  Created by Vladislav Petrov on 14/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit


protocol NoteEditViewControllerDelegate: class {
    func noteEditViewController(vc: NoteEditViewController, didCreatedNote note: Note)
}

class NoteEditViewController: UIViewController {

    @IBOutlet var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTextView: UITextView!
    
    var note: Note?
    let imagePicker = UIImagePickerController()
    weak var delegate: NoteEditViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onImageTap(_:)))
        noteImageView.addGestureRecognizer(tap)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        if let note = note {
            noteImageView.image = note.image
            noteTextView.text = note.text
        }
    }

    @objc func onImageTap(_ sender: Any?) {
        if noteImageView.image == nil {
            present(imagePicker, animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.imageViewTrailingConstraint.isActive = !self.imageViewTrailingConstraint.isActive
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func onClearImageButtonTap(_ sender: Any) {
        if imageViewTrailingConstraint.isActive {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageViewTrailingConstraint.isActive = false
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.noteImageView.image = nil
            })
        }
    }
    
    @IBAction func onSaveButtonTap(_ sender: Any) {
        if let note = note {
            note.image = noteImageView.image
            note.text = noteTextView.text
        } else {
            let note = Note(
                enabled: false,
                text: noteTextView.text,
                image: noteImageView.image)
            
            delegate?.noteEditViewController(vc: self, didCreatedNote: note)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension NoteEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            noteImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
