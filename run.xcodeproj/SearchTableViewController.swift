import UIKit
import CoreMotion

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let tableData = ["One","Two","Three","Twenty-One"]
    var tracks = NSMutableArray()
    var resultSearchController = UISearchController()
    var imageCache = [String:UIImage]()
    let motionManager: CMMotionManager = CMMotionManager()
    var rotation = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                
                self!.rotation = atan2(data.gravity.x, data.gravity.y) - M_PI
                
//                if (self!.rotation < -0.3 && self!.rotation > -6.0) {
//                    if (self!.rotation < -3.0 ) {
//                        self!.rotation = -6.0
//                    } else {
//                        self!.rotation = -0.3
//                    }
//                }
            }
        }

        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)

        
        // Reload the table
        self.tableView.reloadData()
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.reloadData()
    }
    
    func update() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath)
            as! SearchCell
        
        searchCell.labelTrack.text = "Test Cell " + String(indexPath.row + 1)
        searchCell.labelArtistAlbum.text = "Subtitle " + String(indexPath.row + 1)
        searchCell.imgTrack.layer.cornerRadius = searchCell.imgTrack.frame.size.width / 2
        searchCell.imgTrack.layer.borderWidth = 3.0
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            searchCell.transform = CGAffineTransformMakeRotation(CGFloat(self.rotation))
        }, completion: nil)
        return searchCell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
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
