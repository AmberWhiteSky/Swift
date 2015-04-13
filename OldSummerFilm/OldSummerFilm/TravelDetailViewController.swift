//
//  TravelDetailViewController.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/13.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit

class TravelDetailViewController: UITableViewController {

    
    @IBOutlet var headerView: UIView!
    
    var sid:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.httpRequest(Config.shareInstance().travelInformationKey, sid: sid)
    }
    
    func httpRequest(key:String, sid:String){
        
        RequestManager.shareInstance().httpRequest(Config.shareInstance().travelDetail + key + "&sid=" + sid, completionHandler: { (data) -> Void in
            
            if data as! NSObject == NSNull(){
                
                println("加载失败")
                
            }else{
                
                if data["reason"] as! String == "Success"{
                    
                    println(data)
                }
                if data["reason"] as! String == "KeyRequestOverLimit"{
                    
                    println("请求次数超过限制")
                }
            }
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var number:Int!
        
        if section==0{
        
            number = 1
        }
        if section==1{
        
            number = 2
        }
        
        return number
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var h:CGFloat!
        
        if indexPath.section==0{
        
            h=UIScreen.mainScreen().bounds.size.width * 479/962
        }
        if indexPath.section==1{
        
            h = 44
        }
        return h
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
