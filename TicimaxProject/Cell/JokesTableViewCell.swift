//
//  JokesTableViewCell.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 5.08.2022.
//

import UIKit
import SnapKit

class JokesTableViewCell: UITableViewCell {
    
    static let identifier = "JokesTableViewCell"
    
        var label1 = UILabel()
    
        private let parentView : UIView =
        {
            let parentView = UIView()
            parentView.backgroundColor = UIColor.init().UIColorFromHex(rgbValue: 0xFFFFFF, alpha: 1)
            parentView.layer.cornerRadius = 10
            return parentView
        }()

        private let photoView : UIImageView =
        {
           let photoView = UIImageView()
           photoView.roundCorners([.topLeft, .topRight], radius: 10)
           photoView.backgroundColor = UIColor.init().UIColorFromHex(rgbValue: 0xE5E5E5, alpha: 1)
           return photoView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            contentView.backgroundColor = UIColor.init().UIColorFromHex(rgbValue: 0xE5E5E5, alpha: 1)
            
            contentView.addSubview(parentView)
            parentView.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(265)
                make.edges.equalToSuperview().inset(25)
                make.top.equalToSuperview().inset(0)
            }
            
            parentView.addSubview(photoView)
            photoView.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(168)
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            
            createUILabel(label: UILabel(),parentView: parentView, labelText: "Name:", textColor:  UIColor.black, offset: -45, inset: 10, bottomLeading: true)
            createUILabel(label: label1,parentView: parentView, labelText: "Input", textColor:  UIColor.gray, offset: -45, inset: 65, bottomLeading: true)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func createUILabel(label : UILabel,parentView: UIView, labelText: String,textColor: UIColor, offset: Int, inset: Int, bottomLeading : Bool)
        {
            label.textColor = textColor
            label.text = labelText
            parentView.addSubview(label)
            label.snp.makeConstraints { (make) -> Void in
                if bottomLeading
                {
                    make.bottom.equalToSuperview().offset(offset)
                    make.leading.equalToSuperview().inset(inset)
                }
                else
                {
                    make.top.equalToSuperview().offset(offset)
                    make.trailing.equalToSuperview().inset(inset)
                }
                
            }
        }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var item: Meme! {
        didSet {
            setProductData()
        }
    }
    
    private func setProductData() {
        let url = URL(string: (item.url))
                    let data = try? Data(contentsOf: url!)

                    if let imageData = data {
                        self.photoView.image  = UIImage(data: imageData)
                    }
        
        
        self.label1.text = item.name
    }
    
}


