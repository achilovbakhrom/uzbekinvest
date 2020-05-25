//
//  CommentsView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class CommentsView: UIView {
    
    
    @IBOutlet weak var commentTextField: SimpleTextField!
    @IBOutlet weak var createButton: Button!
    
    var onCreateIncident: (() -> Void)? = nil
    var onCommentsChange: ((String) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentTextField.onChange = onCommentsChange
    }
    
    @IBAction func createButtonAction(_ sender: Any) {
        self.onCreateIncident?()
    }
    
}
