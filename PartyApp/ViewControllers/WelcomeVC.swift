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
import GoogleMaps

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
    static let goToGoogleMaps = Notification.Name("goToGoogleMaps")
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
    
    //var parties: [PartyVMProtocol] = []
    //var friends: [FriendVMProtocol] = []
    var user: UserVMProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadingView.frame = self.view.frame
        self.navigationItem.title = NSLocalizedString("WelcomeVCTitle", comment: "")
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange),
                                               name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToPartyFromNotification),
                                               name: .goToGoogleMaps, object: nil)
        
        InitService.shared.getInitData(ConfigurationSrings.apiURL.rawValue)
        
        partyButton.setTitle(NSLocalizedString("toparty", comment: ""), for: .normal)
        friendsButton.setTitle(NSLocalizedString("tofriends", comment: ""), for: .normal)
        profileButton.setTitle(NSLocalizedString("toprofile", comment: ""), for: .normal)
        
        partyButton.isEnabled=false
        friendsButton.isEnabled=false
        profileButton.isEnabled=false
        
        addUserNotifications()
        //AbstractService.shared.fetchRequest<Friends>(with: nil)
    }
    
    @objc func userDefaultsDidChange(){
        if(userDefaults.bool(forKey: "IsDataInitialized")){
            //loadingView.hide()
            partyButton.isEnabled=true
            friendsButton.isEnabled=true
            profileButton.isEnabled=true
        }
        else{
            //loadingView.show()
        }
    }
    
    @IBAction func toPartyListButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self)
        
    }
    
    @objc func goToPartyFromNotification() {
        performSegue(withIdentifier: StoryboardSegues.ToPartyListVCFromNotification, sender: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .didReceivedPartiesData, object: nil)
    }
    
    @objc func fetchDataStatusUpdate(_ notification:Notification) {
        //notification.userInfo
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
     //   notification.userInfo?["status"]
        
        //performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self) //WHAT
    }
    
    @IBAction func toFriendListButtonTapped(_ sender: UIButton) {
        //REDO
        self.performSegue(withIdentifier: StoryboardSegues.ToFriendsList, sender: self)
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
        let trigger5sec = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
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
                                                         actions: [openMap, deleteAction, snoozeAction],
                                                         intentIdentifiers: ["vistulaMaps", "vistulaDelete"],
                                                         options: [])
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        //case StoryboardSegues.ToPartyList:
            
        case StoryboardSegues.ToPartyListVCFromNotification:
            // fetch Vistula Party
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Parties")
            request.predicate = NSPredicate(format: "title = %@", "Spacer nad wisełką")
            do {
                let vistulaParty = (try moc.fetch(request) as! [Parties]).first!
                
                let destinationVC = segue.destination as! UITabBarController
                destinationVC.selectedIndex = 2
                
                let googleMapsVC = destinationVC.viewControllers![2] as! GoogleMapsViewController
                googleMapsVC.selectedParty = PartyVM(party: vistulaParty)
            } catch {
                print("Failed fetching VistulaParty data")
            }
        default:
            print("Default case for segue")
        }
    }
}


    

