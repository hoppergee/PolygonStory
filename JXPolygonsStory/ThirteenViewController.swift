//
//  ThirteenViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 03/11/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class ThirteenViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.animationImages = [#imageLiteral(resourceName: "yay_triangle.png"),#imageLiteral(resourceName: "yay_triangle_blink.png")]
        imageView1.animationDuration = 2
        imageView1.startAnimating()
        
        imageView3.animationImages = [#imageLiteral(resourceName: "yay_triangle.png"),#imageLiteral(resourceName: "yay_triangle_blink.png")]
        imageView3.animationDuration = 2.7
        imageView3.startAnimating()
        
        imageView5.animationImages = [#imageLiteral(resourceName: "yay_triangle.png"),#imageLiteral(resourceName: "yay_triangle_blink.png")]
        imageView5.animationDuration = 2.1
        imageView5.startAnimating()
        
        imageView7.animationImages = [#imageLiteral(resourceName: "yay_triangle.png"),#imageLiteral(resourceName: "yay_triangle_blink.png")]
        imageView7.animationDuration = 2.3
        imageView7.startAnimating()
        
        imageView2.animationImages = [#imageLiteral(resourceName: "yay_square.png"),#imageLiteral(resourceName: "yay_square_blink.png")]
        imageView2.animationDuration = 2.6
        imageView2.startAnimating()
        
        imageView4.animationImages = [#imageLiteral(resourceName: "yay_square.png"),#imageLiteral(resourceName: "yay_square_blink.png")]
        imageView4.animationDuration = 2.5
        imageView4.startAnimating()
        
        imageView6.animationImages = [#imageLiteral(resourceName: "yay_square.png"),#imageLiteral(resourceName: "yay_square_blink.png")]
        imageView6.animationDuration = 3
        imageView6.startAnimating()
        
        imageView8.animationImages = [#imageLiteral(resourceName: "yay_square.png"),#imageLiteral(resourceName: "yay_square_blink.png")]
        imageView8.animationDuration = 2.4
        imageView8.startAnimating()
        
    }
    @IBAction func returnAction(_ sender: UIButton) {
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
