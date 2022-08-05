//
//  Extensions.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 5.08.2022.
//

import Foundation
import UIKit

extension UIColor
{
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor
    {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

extension UIView{
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
           clipsToBounds = true
           layer.cornerRadius = radius
           layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
     }
}


extension UIImageView{
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


extension UILabel
{
    
    func addTrailing(image: UIImage, text:String)
    {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let padding = NSTextAttachment()
        //Use a height of 0 and width of the padding you want
        if text.count == 4
        {
            padding.bounds = CGRect(x:0, y:0, width: 216, height: 0)
        }
        else
        {
            padding.bounds = CGRect(x:0, y:0, width: 200, height: 0)
        }
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])
        string.insert(NSAttributedString(attachment: padding), at: text.count)

        string.append(attachmentString)
        self.attributedText = string
    }
}







