//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var questionTableView: UITableView!
    @IBOutlet weak var segmentedTabber: UISegmentedControl!
    @IBOutlet weak var menuIcon: UIBarButtonItem!
    
    var popupDrawerIsShowing = false
    var questions: Array<PFObject> = [PFObject]()
    let fakeData = ["this", "thaat"]
    var currentGeo: PFGeoPoint!
    let locationManager = CLLocationManager()
    var radius: Double = 5.0
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil
        {
            self.getQuestions()
            
            navigationController!.navigationBar.barTintColor = OurColors.ponderBlue
            navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            navigationController!.navigationBar.tintColor = UIColor.whiteColor()
            
            questionTableView.separatorStyle = .None
            questionTableView.backgroundColor = OurColors.ultraLightGray
            
            self.questionTableView.addSubview(refreshControl)
            
            let font = UIFont.systemFontOfSize(25
            )
            menuIcon.setTitleTextAttributes([NSFontAttributeName:font], forState: UIControlState.Normal)
            
            let leftRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
            leftRecognizer.direction = .Left
            self.view .addGestureRecognizer(leftRecognizer)
            
            let rightRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
            rightRecognizer.direction = .Right
            self.view .addGestureRecognizer(rightRecognizer)
        }
        else
        {
            print("should segue")
            performSegueWithIdentifier("goToSignin", sender: self)
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl)
    {
        questions = [PFObject]()
        self.getQuestions()
        questionTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func switchQuestionType(sender: UISegmentedControl)
    {
        getQuestions()
//        questionTableView.reloadData()
        print("segmented tab pressed")
    }
    
   
    @IBAction func logoutPressed(sender: UIButton)
    {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func getQuestions()
    {
        questions = [PFObject]()
        if segmentedTabber.selectedSegmentIndex == 0
        {
            getDirectQuestions()
            print("got direct")
        }
        else
        {
            getLocalQuestions()
            print("got local")
        }
    }
    
    func getLocalQuestions()
    {
        self.setLocation()
        
        let query = PFQuery(className: "Question")
        query.whereKey("local", equalTo: true)
        query.whereKey("location", nearGeoPoint: currentGeo, withinMiles: radius)
        
        self.questions = query.findObjects() as! Array<PFObject>
        
    }
        
    func getDirectQuestions()
    {
        let user: PFUser = PFUser.currentUser()!
        let userData: PFObject = user["userData"] as! PFObject
        userData.fetchIfNeeded()
        
        let groups: Array<PFObject> = userData["groups"] as! Array<PFObject>

        questions = userData["askedQuestions"] as! Array<PFObject>
    }
    
    // MARK: Table View

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if questions.count > 0
        {
            return questions.count
        }
        else
        {
            return 1
        }
        
    }
    
    func setLocation ()
    {
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        
        self.currentGeo = PFGeoPoint(location: locationManager.location)
        
        print(self.currentGeo.description)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!QuestionCell
        
        if questions.count > 0
        {
            let questionAnswers = (questions[indexPath.row]["answers"] as! Array<String>)
//            if questionAnswers.count <= 4
//            {
//                cell.table.scrollEnabled = false
//            }
//            else
//            {
//                cell.table.scrollEnabled = true
//            }
//            
//            cell.label.text = questions[indexPath.row]["question"] as! String
//            if let creator = questions[indexPath.row]["creator"]
//            {
//                creator.fetchIfNeeded()
//                cell.sentFromName.text = creator["username"] as! String
//            }
//
//            cell.question = questions[indexPath.row]
//            let results = questions[indexPath.row]["results"] as! Array<Array<PFUser>>
//            cell.results = results
//            
//            var eachOneChosen = [Double]()
//            for result in results
//            {
//                eachOneChosen.append(Double(result.count))
//            }
//            cell.numTimesOptionsChosen = eachOneChosen
//            cell.table.reloadData()
//           
//            cell.selectionStyle = .None
        }
        else
        {

            cell.hidden = true
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if questions.count > 0
        {
            cell.contentView.backgroundColor = OurColors.ultraLightGray
            let cardView : UIView = UIView(frame: CGRectMake(self.view.frame.size.width * 0.035, 5, self.view.frame.size.width * 0.95, 355))
            cardView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
            cardView.layer.masksToBounds = false
            cardView.layer.cornerRadius = 1.5
//          cardView.layer.shadowColor = UIColor.blackColor().CGColor
//          cardView.layer.shadowOpacity = 0.2
//          cardView.layer.shadowRadius = 2.5
//          cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell.contentView.addSubview(cardView)
            cell.contentView.sendSubviewToBack(cardView)
        }
    }
    
    @IBAction func directOrLocalPressed(sender: UIButton)
    {
        performSegueWithIdentifier("goToQuestionCreation", sender: self)
    }
    
    
    @IBAction func accountMenuPressed(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("showAccountPopup", sender: self)
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("showAddMenu", sender: self)
    }
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue)
    {}
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer)
    {
        self.performSegueWithIdentifier("showAddMenu", sender: self)
    }
    
    func swipeRight(recognizer : UISwipeGestureRecognizer)
    {
        self.performSegueWithIdentifier("showAccountPopup", sender: self)
    }
}