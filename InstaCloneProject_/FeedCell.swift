//
//  FeedCell.swift
//  InstaCloneProject_
//
//  Created by Şeyma Nur on 14.04.2021.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
 
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func likeClicked(_ sender: Any) {
        let firestore = Firestore.firestore()
        
        if let likecount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likecount + 1] as [String:Any]
            
            firestore.collection("Posts").document(idLabel.text!).setData(likeStore,merge: true)
        }
    }
}
