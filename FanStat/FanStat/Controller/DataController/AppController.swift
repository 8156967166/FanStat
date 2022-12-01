//
//  AppController.swift
//
//
//  Created by AppStationMacMini on 11/03/20.
//  Copyright © 2020 Appstation. All rights reserved.
//

import Foundation
import SJFrameSwift

public class AppController {
    var storageUserProfileFileName = "UserProfile.objc"
    var storageCountryFileName = "countryFile.objc";

    static let shared = AppController()
    var interAppCommunication:InterAppCommunication?
    
    var deviceToken:String = ""
    var objViewHeaderData:Any?

    //var firestoreUid:String = ""
    //var userData:UserClass = UserClass([:])
    
    var isFromLanguageTogggle = false
    private var authorizationToken:String?
    public var temperoryAuthToken:String?
    
    var objInterAppCommunication:InterAppCommunicationController = InterAppCommunicationController()
    var selectedTabIndex:Int?
    var isFromBackground:Bool = false

    init() {
        addLocalisedLanguages()
        
        //Loader View
        SJFrame.settings.isHaveRTL = true
        SJFrame.settings.loaderViewBackgroundColor =  UIColor(red: 57/255, green: 190/255, blue: 227/255, alpha: 0.1)
        SJFrame.settings.loaderBackgroundColor = UIColor.white
        SJFrame.settings.loaderStrokeColor = UIColor(rgb: 0xE75E16)
        SJFrame.settings.setLoaderSize(size: 70)
        SJFrame.settings.setLoaderIconSize(size:60)
        SJFrame.settings.setloaderStrokeWidth(width:2)
    }
    
    // MARK: Localisation
    func addLocalisedLanguages() ->Void{
        let english:SJLocale = SJLocale("English(EN)", _countryName: "United Kingdom", _languageCode: "en", _countryCode: "gb");
        let arabic:SJLocale = SJLocale("Arabic(AR)", _countryName: "Arabic", _languageCode: "ar", _countryCode: "ar");
        
        SJLocalisedString.addLocalisedLanguage(local: english);
        SJLocalisedString.addLocalisedLanguage(local: arabic);
    }
    
    func setAppLanguage(objLanguage:SJLocale?) -> Void {
        if let lang = objLanguage{
            SJLocalisedString.setLanguage(local: lang);
        }else{
            SJLocalisedString.setDefaultLanguage();
        }
    }
    
    func isAppLanguageArabic() -> Bool {
        var status = false;
        guard let objLocalLanguage:SJLocale = SJLocalisedString.getSelectedLocale() else{
            return status;
        }
        if(objLocalLanguage.languageCode?.lowercased() == "ar"){
            status = true;
        }
        return status;
    }
    
    
    func toggleAppGUILanguage() -> Void {
        if(isAppLanguageArabic()){
            let english:SJLocale = SJLocale("English(EN)", _countryName: "United Kingdom", _languageCode: "en", _countryCode: "gb");
            SJLocalisedString.setLanguage(local: english)
        }else{
            let arabic:SJLocale = SJLocale("Arabic(AR)", _countryName: "Arabic", _languageCode: "ar", _countryCode: "ar");
            SJLocalisedString.setLanguage(local: arabic);
        }
        //        NotificationCenter.default.post(name: NSNotification.Name.appLanguageChange, object: nil);
        
    }
    
    // MARK: Logout & Clear
    func logOut(){
        //loggedUser = UserClass([:])
        deviceToken = ""
        authorizationToken = ""
        temperoryAuthToken = ""
        let defaults = UserDefaults.standard
        defaults.set(authorizationToken, forKey: "userToken")
        defaults.set(temperoryAuthToken, forKey: "temperoryAuthToken")
        clearLoggedUserData()
    }
    
    func clearLoggedUserData(){
        SJDataCache.store(Data(), to: .documents, as: storageUserProfileFileName)
        NotificationCenter.default.post(name: Notification.Name("updateUserInfo"), object: nil)
    }
     
    
    // MARK: Check Internet
    public func checkInternetAvailability(_ showBanner:Bool = true)->Bool{
        if !CheckInternet.Connection(){
            //objViewHeaderData = "No Internet, Please check"
            if showBanner{postCommonMessage(SJLocalisedString["key_APP_msg_CHECK_INTERNET"])}
            return false
        }else{
            return true
        }
    }
    
    public func postCommonMessage(_ message:String){
        objViewHeaderData = message
        NotificationCenter.default.post(name: NSNotification.Name.appShowHeaderMessage, object: nil)
    }
    
    
    //MARK: CHECK USER IS LOGGED IN
    
    func isLoggedIn()->Bool{
        guard let token = getAuthorizationToken() else {
            return false
        }
        
        if token == ""{
            return false
        }
        return true
    }
    
    //MARK: SAVE & GET TEMP BEARER TOKEN
    
    public func getTempAuthorizationToken()->String? {
        if let token = temperoryAuthToken, !token.isEmpty {
            return token
            
        }
        let defaults = UserDefaults.standard
        if let token = defaults.object(forKey: "tempUserToken") as? String {
            if !token.isEmpty {
                temperoryAuthToken = token
                return token
                
            }else{
                return nil
                
            } }
        return nil;
        
    }
    public func setTempAuthorizationToken(_ token:String){
        let defaults = UserDefaults.standard
        if token.isEmpty {
            temperoryAuthToken = ""
            defaults.set(token, forKey: "tempUserToken")
            
        }else{
            temperoryAuthToken = token
            defaults.set(token, forKey: "tempUserToken")
            
        }
        
    }

    
    //MARK: SAVE & GET BEARER TOKEN
    
    public func getAuthorizationToken()->String? {
        if let token = authorizationToken, !token.isEmpty {
            return token
            
        }
        let defaults = UserDefaults.standard
        if let token = defaults.object(forKey: "userToken") as? String {
            if !token.isEmpty {
                authorizationToken = token
                return token
                
            }else{
                return nil
                
            } }
        return nil;
        
    }
    public func setAuthorizationToken(_ token:String){
        let defaults = UserDefaults.standard
        if token.isEmpty {
            authorizationToken = ""
            defaults.set(token, forKey: "userToken")
            
        }else{
            authorizationToken = token
            defaults.set(token, forKey: "userToken")
            
        }
        
    }
    
}

// MARK: CUSTOM FONT
class AppFont{
    
    enum FontType {
        case regular
        case bold
        case light
        case semibold
        case extraBold
        case medium
    }
    
    class func get(type:FontType,size:CGFloat) -> UIFont {
        
        let isArabic = AppController.shared.isAppLanguageArabic();
        
        switch type {
        case FontType.regular:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Regular", size: size) : UIFont(name: "HelveticaNowDisplay-Regular", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.bold:
//            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Bold", size: size) : UIFont(name: "HelveticaNowDisplay-Bold", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.bold:
            return (isArabic ? UIFont(name: "Jotia-Bold", size: size) : UIFont(name: "Jotia-Bold", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.semibold:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.extraBold:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.light:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Thin", size: size) : UIFont(name: "HelveticaNowDisplay-Thin", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.medium:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    class func getEnglish(type:FontType,size:CGFloat) -> UIFont {
        
        let isArabic = AppController.shared.isAppLanguageArabic();
        
        switch type {
        case FontType.regular:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Regular", size: size) : UIFont(name: "HelveticaNowDisplay-Regular", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.bold:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Bold", size: size) : UIFont(name: "HelveticaNowDisplay-Bold", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.semibold:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.extraBold:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.light:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Thin", size: size) : UIFont(name: "HelveticaNowDisplay-Thin", size: size)) ?? UIFont.systemFont(ofSize: size)
        case FontType.medium:
            return (isArabic ? UIFont(name: "HelveticaNowDisplay-Medium", size: size) : UIFont(name: "HelveticaNowDisplay-Medium", size: size)) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    
    
    class func getTextAlignment() -> NSTextAlignment{
        let isArabic = AppController.shared.isAppLanguageArabic();
        if(isArabic){
            return NSTextAlignment.right;
        }else{
            return NSTextAlignment.left;
        }
    }
    
}

struct InterAppCommunication {
    var verificationId:String?// = "123456"//vc
    var newsId:String?
    var notificationId:String? = "123456"
    
    init(_ dict:[String:Any]) {
        if let value = dict["newsId"] as? String{
            newsId = value
        }else if let value = dict["notificationId"] as? String{
            notificationId = value
        }else if let value = dict["verificationId"] as? String{
            verificationId = value
        }
    }
}

// MARK: INTER APP COMMUNICATION
class InterAppCommunicationController {
    
    var strNotificationRequestId:String?
    
    func isAppCustomURLSchem(URLOfDeeplink:String?) -> Bool {
        
        guard let deepLink = URLOfDeeplink else{
            return false;
        }
        if(deepLink == ""){
            return false;
        }
        
        
        return false;
    }
    
    
    func isHaveInterAppNavigations() -> Bool {
        var status = false;
        if((strNotificationRequestId != nil && strNotificationRequestId != "")){
            status = true;
        }
        else{
            status = false;
        }
        return status;
    }
}



extension Notification.Name {
    static let appEnterForeground = Notification.Name("EnterForeground");
    static let appEnterBackground = Notification.Name("EnterBackground");
    static let appLanguageChange  = Notification.Name("appLanguageChange");
    static let appShowHeaderMessage = Notification.Name("appShowHeaderMessage");
    static let goToProfilePage = Notification.Name("goToProfilePage");
    static let updateUserInfo = Notification.Name("updateUserInfo");
    static let enableWrapperScroll = Notification.Name("enableWrapperScroll")
    static let deepLinkNavigation = Notification.Name("deepLinkNavigation")
    static let receivedPushNotification = Notification.Name("receivedPushNotification")

}


extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}


 
