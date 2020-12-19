//
//  RecommendedViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/07.
//

import UIKit
import SwiftyJSON
import Alamofire


class Recommended3ViewController: UIViewController,UIScrollViewDelegate {
    
    
    /*
     画像集め必要
     スクロールビュー三枚設定中
     
     
     
     pageControlのAutoレイアウトがうまくできない
     スクロールビューとページコントロールをスタックするか？？
     */
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet var imageScrollView2: UIScrollView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var pageScrollView: UIPageControl!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var imageStack: UIStackView!
    
    @IBOutlet var backObj: UIButton!
    @IBOutlet var serchObj: UIButton!
    
    
    
    var latitudeValue = Double()
    var longitudeValue = Double()
    
    
    
    var imageArray = ["小笠原1","小笠原2","小笠原3"]
    var labelNameArray = ["ボニンブルー 小笠原諸島","aaaaaaaaa","1111111111"]
    var addressArray = ["〒100-2101 東京都小笠原村父島東町","",""]
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = labelNameArray[0]
        nameLabel.layer.cornerRadius = 20
        nameLabel.clipsToBounds = true
        addressLabel.text = addressArray[0]
        addressLabel.layer.cornerRadius = 20
        addressLabel.clipsToBounds = true
        
        backObj.layer.cornerRadius = 25
        backObj.clipsToBounds = true
        
        serchObj.layer.cornerRadius = 25
        serchObj.clipsToBounds = true
        
        
        
        
        
        
    
        
        // scrollViewの画面表示サイズを指定
        imageScrollView2 = UIScrollView(frame: CGRect(x: 0, y: 150, width: self.view.frame.size.width, height: imageScrollView2.frame.height))
               // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×ページ数）
        imageScrollView2.contentSize = CGSize(width: self.view.frame.size.width*3, height: imageScrollView2.frame.height)
               // scrollViewのデリゲートになる
        imageScrollView2.delegate = self
               // メニュー単位のスクロールを可能にする
        imageScrollView2.isPagingEnabled = true
               // 水平方向のスクロールインジケータを非表示にする
        imageScrollView2.showsHorizontalScrollIndicator = false
               self.view.addSubview(imageScrollView2)
               
               // scrollView上にUIImageViewをページ分追加する(今回は3ページ分)
        let imageView1 = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: imageScrollView2.frame.height, image: imageArray[0])
        imageScrollView2.addSubview(imageView1)
               
               let imageView2 = createImageView(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: imageScrollView2.frame.height, image: imageArray[1])
        imageScrollView2.addSubview(imageView2)
               
               let imageView3 = createImageView(x: self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width, height: imageScrollView2.frame.height, image: imageArray[2])
        imageScrollView2.addSubview(imageView3)

        

            
        }
        
    
    
    // UIImageViewを生成
       func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: String) -> UIImageView {
           let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
           let image = UIImage(named:  image)
            imageView.image = image
           return imageView
       }
    
    
    

    
    
    
    // scrollViewのページ移動に合わせてpageControlの表示も移動させる
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageScrollView.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
//
    @IBAction func Surrounding_Meals(_ sender: Any) {
        
 
    }
    

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
