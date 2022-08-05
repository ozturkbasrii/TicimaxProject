//
//  DetailViewController.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 5.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedItemURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height));
        
        let url = URL(string: (selectedItemURL))
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
        self.view.addSubview(imageView)
    }
    
}

