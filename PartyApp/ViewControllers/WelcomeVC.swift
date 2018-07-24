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
//import GoogleMaps
import AVKit
import AVFoundation

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
    

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partyButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    @IBOutlet weak var playerView: UIView!
    var partiesDataStatus: FetchStatus = .notStarted
    
    let center = UNUserNotificationCenter.current()
    let userDefaults = UserDefaults.standard
    
    var player: AVPlayer?
    let videoURL = Bundle.main.url(forResource: "onboard", withExtension: "mp4")!
    //let videoURL_R = Bundle.main.url(forResource: "onboardR", withExtension: "mp4")!
    var reverse = false;
    
    
    //var parties: [PartyVMProtocol] = []
    //var friends: [FriendVMProtocol] = []
    var user: UserVMProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyButton.layer.cornerRadius = 10
        friendsButton.layer.cornerRadius = 10
        profileButton.layer.cornerRadius = 10
        
        //loadingView.frame = self.view.frame
        self.navigationItem.title = NSLocalizedString("WelcomeVCTitle", comment: "")
//        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        partyButton.isHidden=true
//        friendsButton.isHidden=true
//        profileButton.isHidden=true
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange),
                                               name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToPartyFromNotification),
                                               name: .goToGoogleMaps, object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playVideo), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        InitService.shared.getInitData(ConfigurationSrings.apiURL.rawValue)
        
        partyButton.setTitle(NSLocalizedString("toparty", comment: ""), for: .normal)
        friendsButton.setTitle(NSLocalizedString("tofriends", comment: ""), for: .normal)
        profileButton.setTitle(NSLocalizedString("toprofile", comment: ""), for: .normal)
        
        partyButton.isEnabled=false
        friendsButton.isEnabled=false
        profileButton.isEnabled=false
        
        addUserNotifications()
        
        videoMakerPartyShaker()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
//        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
//            UIBlurEffectStyle.dark))
//        blur.frame = testButton.bounds
//        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
//        testButton.insertSubview(blur, at: -1)
        
        titleLabel.alpha=0.0
        titleLabel.layer.shadowOpacity=0.5
        
        
                        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
                            self.buttonsStackView.center = CGPoint(x: self.buttonsStackView.center.x, y: self.buttonsStackView.center.y-300)
                            self.titleLabel.alpha=0.8

                        }, completion: { _ in
                            UIView.animate(withDuration: 1, animations: {
                                         self.buttonsStackView.center = CGPoint(x: self.buttonsStackView.center.x, y: self.buttonsStackView.center.y)
                                //self.titleLabel.alpha=0.75
                            })

                        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player?.play()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
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
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    func videoMakerPartyShaker(){
        
        //let videoURL = Bundle.main.url(forResource: "onboard", withExtension: "mp4")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        //view.layer.addSublayer(playerLayer)
        playerView.layer.addSublayer(playerLayer)
        player?.play()
        
        //loop video
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(WelcomeVC.loopVideo),
                                                         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                         object: nil)
    }
    @objc func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    @objc func playVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
}



    

