//
//  CityViewController.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/12.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit
import CoreData

class CityViewController: UITableViewController {
    
    var hotCityArray=NSMutableArray()
    var commonArray:Array<AnyObject> = []
    
    //运用CoreData 访问AppDelegate里面的方法
    var context:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var f = NSFetchRequest(entityName: "City")
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //查询所有数据
        commonArray = context.executeFetchRequest(f, error: nil)!
        
        self.httpRequest(Config.shareInstance().travelInformationKey)
    }
    
    func httpRequest(key:String){
    
        RequestManager.shareInstance().httpRequest(Config.shareInstance().cityList + key, completionHandler: { (data) -> Void in
            
            if data as! NSObject == NSNull(){
                
                println("加载失败")
                
            }else{
                
                if data["reason"] as! String == "Success"{
                    
                    var arr = data["result"] as! NSArray
                    
                    for data : AnyObject in arr{
                        
                        self.hotCityArray.addObject(data)
                    }
                    
                    self.tableView.reloadData()
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
        
            number=commonArray.count
        }
        if section==1{
        
            number=hotCityArray.count
        }
        
        return number
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        if indexPath.section==0{
        
            cell.textLabel?.text = commonArray[indexPath.row].valueForKey("cityName") as? String
        }
        if indexPath.section==1{
            
            cell.textLabel?.text=hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityName") as? String
        }
        
        if Config.shareInstance().getCurrentCityName()==cell.textLabel?.text{
        
            cell.textLabel?.textColor = UIColor.orangeColor()
        }else{
        
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title:String!
        
        if section==0{
            
            title = "常用城市"
        }
        if section==1{
        
            title = "热门城市"
        }
        
        return title
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section==0{
            
            Config.shareInstance().saveCurrentCity((commonArray[indexPath.row].valueForKey("cityName") as? String)!, cityId: (commonArray[indexPath.row].valueForKey("cityId") as? String)!, proviceId: (commonArray[indexPath.row].valueForKey("provinceId") as? String)!)
            
        }
        if indexPath.section==1{
            
            Config.shareInstance().saveCurrentCity((hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityName") as? String)!, cityId: (hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityId") as? String)!, proviceId: (hotCityArray.objectAtIndex(indexPath.row).objectForKey("provinceId") as? String)!)
            
            
            for data:AnyObject in commonArray as NSArray{
                
                let currentStr:String = data.valueForKey("cityName") as! String
                let indexStr:String = hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityName") as! String
                
                if currentStr == indexStr{
                
                    //删除一条数据
                    context.deleteObject(data as! NSManagedObject)
                }
            }
            
            //插入一条数据
            var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("City", inManagedObjectContext: context)
            row.setValue((hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityName") as? String)!, forKey: "cityName")
            row.setValue((hotCityArray.objectAtIndex(indexPath.row).objectForKey("cityId") as? String)!, forKey: "cityId")
            row.setValue((hotCityArray.objectAtIndex(indexPath.row).objectForKey("provinceId") as? String)!, forKey: "provinceId")
        }
    
        //通知的发出
        NSNotificationCenter.defaultCenter().postNotificationName("updataCityName", object:nil)
        
        self.navigationController?.popViewControllerAnimated(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
