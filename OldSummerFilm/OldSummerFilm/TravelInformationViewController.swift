//
//  TravelInformationViewController.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/12.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit

class TravelInformationViewController: UITableViewController{

    @IBOutlet var cityBtn: UIButton!
    
    var listArray = NSMutableArray()
    
    var pageNumber = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        cityBtn.setTitle(Config.shareInstance().getCurrentCityName(), forState: UIControlState.Normal)
        
        //通知的接受
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"doNotify", name: "updataCityName", object: nil)
        
        //获取数据
        self.httpRequest(Config.shareInstance().travelInformationKey, pid: Config.shareInstance().getCurrentProviceId(), cid: Config.shareInstance().getCurrentCityId(), page: "\(pageNumber)")
    }
    
    //请求数据
    func httpRequest(key:String, pid:String, cid:String, page:String){
    
        RequestManager.shareInstance().httpRequest(Config.shareInstance().travelList + key + "&pid=" + pid + "&cid=" + cid + "&page=" + page, completionHandler: { (data) -> Void in
            
            if data as! NSObject == NSNull(){
                
                println("加载失败")
                
            }else{
                
                if data["reason"] as! String == "Success"{
                    
                    var arr = data["result"] as! NSArray
                    
                    for data : AnyObject in arr{
                        
                        self.listArray.addObject(data)
                    }
                    
                    self.tableView.reloadData()
                    
                }
                if data["reason"] as! String == "KeyRequestOverLimit"{
                    
                    println("请求次数超过限制")
                }
                
            }
            
        })
    }
    
    
    //实现通知
    func doNotify(){
        
        cityBtn.setTitle(Config.shareInstance().getCurrentCityName(), forState: UIControlState.Normal)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "updataCityName", object: nil)
    }

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    */

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listArray.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TravelInformationCell
        
        cell.travelNameLB.text = listArray.objectAtIndex(indexPath.row).objectForKey("title") as? String
        cell.travelGradeLB.text = listArray.objectAtIndex(indexPath.row).objectForKey("grade") as? String
        cell.travelAddressLB.text = listArray.objectAtIndex(indexPath.row).objectForKey("address") as? String
        cell.travelPriceLB.text = listArray.objectAtIndex(indexPath.row).objectForKey("price_min") as? String
        
        cell.loadImageView((listArray.objectAtIndex(indexPath.row).objectForKey("imgurl") as? String)!)
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "travelDetail"{
            
            //选中的Cell的IndexPath
            var index:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            
            var theSegue:AnyObject = segue.destinationViewController
            theSegue.setValue(listArray.objectAtIndex(index.row).objectForKey("sid") as? String, forKey: "sid")
        }
        
    }

}
