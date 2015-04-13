//
//  TravelInformationCell.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/13.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit

class TravelInformationCell: UITableViewCell {

    
    @IBOutlet var travelImageView: UIImageView!
    
    @IBOutlet var travelNameLB: UILabel!
    
    @IBOutlet var travelGradeLB: UILabel!
    
    @IBOutlet var travelAddressLB: UILabel!
    
    @IBOutlet var travelPriceLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImageView(urlStr: String){
    
        var network_queue:dispatch_queue_t!
        network_queue = dispatch_queue_create("com.app.network", nil)
        dispatch_async(network_queue, { () -> Void in
            
            var cellImage = self.loadMyImageFormNetwork(urlStr)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              
                self.travelImageView.image = cellImage
            })
        })
        
    }
    
    func loadMyImageFormNetwork(url:String)->UIImage{
    
        var dat = NSData(contentsOfURL: NSURL(string: url)!)
        var image = UIImage(data: dat!)
        
        return image!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
