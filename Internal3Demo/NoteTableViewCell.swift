//
//  NoteTableViewCell.swift
//  Internal3Demo
//
//  Created by Vladislav Petrov on 13/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteSwitch: UISwitch!
    @IBOutlet weak var noteImageBackground: UIView!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    
    var note: Note?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onNoteSwitchChanged(_ sender: Any) {
        switchStatusChanged()
        note?.enabled = noteSwitch.isOn
    }
    
    func configureWith(_ note: Note) {
        self.note = note
        
        noteSwitch.isOn = note.enabled
        switchStatusChanged()
        noteLabel.text = note.text
        noteImageView.image = note.image
    }
    
    private func switchStatusChanged() {
        let alpha: CGFloat = noteSwitch.isOn ? 0.4 : 1
        noteLabel.alpha = alpha
        noteImageBackground.alpha = alpha
    }
}
