//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Masatsugu Koga on 2025/03/05.
//

import UIKit

/// スライドショーを管理するビューコントローラー
class ViewController: UIViewController {

    // MARK: - IBOutlet
        
    /// スライドショーの画像を表示するビュー
    @IBOutlet weak var imageView: UIImageView!
    
    /// 次の画像に進むボタン
    @IBOutlet weak var nextButton: UIButton!
    
    /// 前の画像に戻るボタン
    @IBOutlet weak var prevButton: UIButton!
    
    /// スライドショーの再生/停止ボタン
    @IBOutlet weak var playPauseButton: UIButton!

    // MARK: - プロパティ
    
    /// スライドショーで表示する画像の配列（Assetsに登録された画像名）
    let images = ["grape.png", "grapefruit.png", "lemon.png"]
    
    /// 現在表示している画像のインデックス
    var currentIndex = 0
    
    /// スライドショーのタイマー（nilの場合は停止中）
    var timer: Timer?
    
    // MARK: - ライフサイクルメソッド
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 初期画像を設定
        imageView.image = UIImage(named: images[currentIndex])
        
        // タップジェスチャーをコードで追加する方法（手動で設定する場合）
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        //imageView.addGestureRecognizer(tapGesture) // `UIImageView` にジェスチャーを追加
        //imageView.isUserInteractionEnabled = true // タップ操作を有効化
    }
    
    // 画面遷移の準備を行うメソッド。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.selectedImage = images[currentIndex] // 現在表示中の画像を渡す
        }
    }

    //: - アクションメソッド
    
    /// 次の画像を表示するメソッド。
    @IBAction func nextImage(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % images.count
        imageView.image = UIImage(named: images[currentIndex])
    }
    
    /// 前の画像を表示するメソッド。
    @IBAction func prevImage(_ sender: UIButton) {
        currentIndex = (currentIndex - 1 + images.count) % images.count
        imageView.image = UIImage(named: images[currentIndex])
    }

    /// スライドショーの再生/停止を切り替えるメソッド。
    @IBAction func playPauseSlideshow(_ sender: UIButton) {
        if timer == nil {
            startSlideshow()
        } else {
            stopSlideshow()
        }
    }
    
    /// 画像がタップされたときに拡大画面へ遷移するメソッド。
    @IBAction func tapImage(_ sender: Any) {
        performSegue(withIdentifier: "toDetailView", sender: nil)
        stopSlideshow()
    }


    // MARK: - スライドショー制御
    
    /// スライドショーを開始するメソッド。
    func startSlideshow() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextSlide), userInfo: nil, repeats: true)
        
        // ボタンの状態を変更
        playPauseButton.setTitle("停止", for: .normal)
        nextButton.isEnabled = false
        prevButton.isEnabled = false
    }
    
    /// スライドショーを停止するメソッド。
    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
        
        // ボタンの状態を元に戻す
        playPauseButton.setTitle("再生", for: .normal)
        nextButton.isEnabled = true
        prevButton.isEnabled = true
    }
    
    /// スライドショーで次の画像を表示するメソッド。
    @objc func nextSlide() {
        nextImage(nextButton)
    }

}

