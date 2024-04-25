//
//  StoryDetailVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.03.2024.
//

import UIKit

class StoryDetailVC: UIViewController {
    
    var imageView = UIImageView()
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
    }
}
