//
//  Note.swift
//  Internal3Demo
//
//  Created by Vladislav Petrov on 13/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class Note {
    var enabled: Bool
    var text: String
    var image: UIImage?
    
    init(enabled: Bool = false, text: String, image: UIImage?) {
        self.enabled = enabled
        self.text = text
        self.image = image
    }
}
