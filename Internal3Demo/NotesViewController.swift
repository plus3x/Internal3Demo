//
//  ViewController.swift
//  Internal3Demo
//
//  Created by Vladislav Petrov on 13/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var notes = [
        Note(text: "Test 1", image: nil),
        Note(text: "TestTestTest 1", image: UIImage(named: "statham")),
        Note(text: "TestTestTest1", image: nil),
        Note(text: "TestTest 1", image: nil),
        Note(text: "TestTestTestTestTestTest 1", image: UIImage(named: "statham")),
        Note(text: "Test  Test Test Test Test Test Test Test Test Test  Test Test Test Test Test Test Test Test Test  Test Test Test Test Test Test Test Test Test  Test Test Test Test Test Test Test Test Test  Test Test Test Test Test Test Test Test Test  Test Test Test Test Test Test Test Test1", image: UIImage(named: "statham")),
        Note(text: "Dick 1", image: nil),
        Note(text: "TestTestTest1", image: nil),
        Note(text: "TestTest 1", image: nil),
        Note(text: "TestTestTestTestTestTest 1", image: UIImage(named: "statham")),
        Note(text: "Test  Test Test Test Test Test Test Test Test1", image: UIImage(named: "statham")),
        Note(text: "Dick 1", image: nil),
    ]
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    @IBAction func onAddButtonTap(_ sender: Any) {
        selectedNote = nil
        showEditViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNoteEditViewController", let vc = segue.destination as? NoteEditViewController {
            vc.delegate = self
            vc.note = selectedNote
        }
    }
    
    private func showEditViewController() {
       performSegue(withIdentifier: "ShowNoteEditViewController", sender: self)
    }
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCellIdentifier", for: indexPath) as! NoteTableViewCell
        
        let note = notes[indexPath.row]
        cell.configureWith(note)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedNote = notes[indexPath.row]
        
        showEditViewController()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension NotesViewController: NoteEditViewControllerDelegate {
    func noteEditViewController(vc: NoteEditViewController, didCreatedNote note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
}
