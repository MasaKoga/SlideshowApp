//
//  DetailViewController.swift
//  SlideshowApp
//
//  Created by Masatsugu Koga on 2025/03/05.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageName = selectedImage {
            detailImageView.image = UIImage(named: imageName)
        }
    }
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
