//
//  WelcomeViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications


/*TODO:
użyć nowego serwisu do pobrania danych i zasilenia core data
 ustwić flage w user defaults że dane już zostały pobrane :) plus observer
 Ustawić localize titles dla każdego viewcontroller i przyciski nawigacji
 Ustawić error handling
 Korzystać z core data do wyswietlania list
 Ustawić nofikacje co godzinę przypomina nad wisełką, dodatkowa akcja otwiera mape z lokalizacją imprezy
 Wrócić do mvvm :)
 */



extension Notification.Name {
    static let didReceivedPartiesData = Notification.Name("didReceiveDataParty")
}

enum FetchStatus {
    case saved
    case inprogress
    case failed
    case notStarted
}

class WelcomeVC: DefaultViewController, UITextFieldDelegate {
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    @IBOutlet weak var partyButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var partiesDataStatus: FetchStatus = .notStarted
    
    let center = UNUserNotificationCenter.current()
    let userDefaults = UserDefaults.standard
    //could be used
    
    
    var parties: [PartyVMProtocol] = []
    var friends: [FriendVMProtocol] = []
    var user: UserVMProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.frame = self.view.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)

        userDefaults.setValue(true, forKey: "isloaded")
        
        let isloaded = userDefaults.bool(forKey: "isloaded")
        if(isloaded) { loadingView.hide() }
        
        GhettoDataLoad() //To CoreData Service
        
        
        partyButton.setTitle(NSLocalizedString("toparty", comment: ""), for: .normal)
        friendsButton.setTitle(NSLocalizedString("tofriends", comment: ""), for: .normal)
        profileButton.setTitle(NSLocalizedString("toprofile", comment: ""), for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceivedPartiesData, object: nil)
        
        
        
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
    
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        
//        let date = Date(timeIntervalSinceNow: 3600)
//        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
//                                                    repeats: false)
        
//        let triggerDaily = Calendar.current.dateComponents([hour,.minute,.second,], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
//        let triggerWeekly = Calendar.current.dateComponents([.weekday,hour,.minute,.second,], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        //let trigger = UNLocationNotificationTrigger(triggerWithRegion:region, repeats:false)
        
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction",
                                                title: "Delete", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: "UYLReminderCategory",
                                              actions: [snoozeAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
        
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("notificationTitle", comment: "")
        content.body = "Damian Idzie po piwko bo nie patrzy :)"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "UYLReminderCategory"
        
        
        if let url = Bundle.main.url(forResource: "beer",
                                     withExtension: "jpg") {
            if let attachment = try? UNNotificationAttachment(identifier:
                "image", url: url, options: nil) {
                content.attachments = [attachment]
            }
        }
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        
        
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
        
        
    
        

        
        addUserNotifications()
    }
    
    @objc func userDefaultsDidChange(){
        print("userdefaultdidchange")
    }
    
    
    @IBAction func toPartyListButtonTapped(_ sender: UIButton) {
        
        //REDO
        self.performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self) //TODLETE
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .didReceivedPartiesData, object: nil)
    }
    
    @objc func fetchDataStatusUpdate(_ notification:Notification) {
        notification.userInfo
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
     //   notification.userInfo?["status"]
        
        //performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self) //WHAT
    }
    
    
    @IBAction func toFriendListButtonTapped(_ sender: UIButton) {
        
        //REDO
        self.performSegue(withIdentifier: StoryboardSegues.ToFriendsList, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
        switch segueId {
        case StoryboardSegues.ToPartyList:
            let destinationVC = segue.destination as! UITabBarController
            let partiesListVC = destinationVC.viewControllers?.first! as! PartiesListVC
            partiesListVC.parties = parties
            let partyMapVC = destinationVC.viewControllers?[1] as! PartyMapViewController
            partyMapVC.parties = parties
         
        case StoryboardSegues.ToFriendsList:
            let destinationVC = segue.destination as! FriendsListVC
            destinationVC.friends = friends
        case StoryboardSegues.ToProfile:
            let destinationVC = segue.destination as! UserInfoVC
            if let user = user {
                destinationVC.user = user
            }
        default:
            fatalError("Unknow segue")
        }
        }
    }
    
    func GhettoDataLoad(){ //Ghetto function -> to CoreData services
        
        //GhettoLoad Parties
        loadingView.show()
        let requestP = GetPartiesRequest()
        partiesDataStatus = .inprogress
        PartiesService.shared.getPartiesList(requestP, success: {[weak self] (parties) in
            self?.parties = parties
            self?.loadingView.hide()
            NotificationCenter.default.post(name: .didReceivedPartiesData, object: nil)
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
        //GhettoLoad Friends
        //loadingView.show()
        let requestF = GetFriendsRequest()
        FriendsService.shared.getFriendsList(requestF, success: { [weak self] (friends) in
            self?.friends = friends
            self?.loadingView.hide()
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
        //GhettoCoreData
        
    }
    
    private func addUserNotifications() {
        
        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            if error == nil {
                print("You gave me a permission to be your pain in the ass")
            } else {
                print("Hey, you didn't give me permission for showing you cool notifications!")
            }
        })
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
    
//        let trigger5sec = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //let trigger1hour = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        let trigger5sec = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let trigger1hour = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction",
                                                title: "Delete", options: [.destructive])
        let openMap = UNNotificationAction(identifier: "GoToMap",
                                           title: "Open in Maps", options: [.authenticationRequired, .foreground])
        let damianNieWidzialCategory = UNNotificationCategory(identifier: "UYLDamianReminderCategory",
                                              actions: [snoozeAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        let vistulaBeerCategory = UNNotificationCategory(identifier: "UYLVistulaReminderCategory",
                                                         actions: [openMap, deleteAction],
                                                         intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([damianNieWidzialCategory, vistulaBeerCategory])
        
        
        let damianContent = UNMutableNotificationContent()
        damianContent.title = NSLocalizedString("notificationTitle", comment: "")
        damianContent.body = "Damian Idzie po piwko bo nie patrzy :)"
        damianContent.sound = UNNotificationSound.default()
        damianContent.categoryIdentifier = "UYLReminderCategory"
        
        let vistulaBeerContent = UNMutableNotificationContent()
        vistulaBeerContent.title = "Vistula Beer"
        vistulaBeerContent.body = "Hej, nad Wisełką czeka piwerko!"
        vistulaBeerContent.sound = UNNotificationSound.default()
        vistulaBeerContent.categoryIdentifier = "UYLVistulaReminderCategory"
        
        if let url = Bundle.main.url(forResource: "beer",
                                     withExtension: "jpg") {
            if let attachment = try? UNNotificationAttachment(identifier:
                "image", url: url, options: nil) {
                damianContent.attachments = [attachment]
            }
        }
        
        let damianIdentifier = "UYLDamianLocalNotification"
        let vistulaIdentifier = "UYLVistulaLocalNotification"
        let damianRequest = UNNotificationRequest(identifier: damianIdentifier,
                                                  content: damianContent, trigger: trigger5sec)
        let vistulaRequest = UNNotificationRequest(identifier: vistulaIdentifier,
                                                   content: vistulaBeerContent, trigger: trigger1hour)
        
        center.add(damianRequest) { error in
            if error != nil {
                print("Couldn't add Damian's notification")
            }
        }
        center.add(vistulaRequest) { error in
            if error != nil {
                print("Couldn't add VistulaBeer notification")
            }
        }
    }
    
    

}

    

