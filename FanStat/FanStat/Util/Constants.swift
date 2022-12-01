//
//  KeyChainManger.swift
//
//
//  Created by AppStationMacMini on 04/02/21.
//  Copyright © 2021 Sreelekshmi. All rights reserved.
//

import Foundation
import UIKit


struct ConstantString {
    static let k_EMPTY:String = ""
    static let k_ZERO:String  = "0"
    static let k_EMPTY_SINGLE_SPACE:String = ""
    static let k_SINGLE_SPACE:String = " "
    static let k_Percentage_20:String = "%20"
    
    static let K_LANGUAGE_EN                                =  "en"
    static let K_LANGUAGE_AR                                =  "ar"
    static let k_DEFAULT_COUNTRY_CODE:String = "+974" //TODO
    static let k_DEFAULT_COUNTRY_ID:String = "VolejRejNm"

    //API Param Keys
    static let k_PASSWORD           =  "password"
    static let k_PASSWORD_CONFIRM   =  "password_confirmation"
    static let k_USER_TYPE          =  "user_type"
    static let k_NAME               =  "name"
    static let k_COUNTRY_ID         =  "country_id"
    static let k_PHONE              =  "phone"

    static let k_LANGUAGE           =  "language"
    static let k_DEVICE_TYPE        =  "device_type"
    static let k_DEVICE_TOKEN       =  "device_token"
    static let k_KEY       =  "key"
    static let k_SHOP_ID   = "shop_id"
    static let k_CATEGORY_ID        =  "category_id"
    static let k_SEARCH_WORD        =  "search_word"
    static let k_ID = "id"
    static let k_TYPE = "type"
    static let k_PRODUCT_ID = "product_id"
    static let k_PACKAGE_ID        =  "package_id"
    static let k_SAVE_CARD         =  "save_card"
    static let k_PAYMENT_ID         =  "payment_id"
    static let k_MESSAGE = "message"
    static let k_OS_TYPE = "os_type"
    static let k_VERSION = "version"
    static let k_MARKETER_ID = "marketer_code"

    static let BLOCKAT_INSTAGRAM_ID = "blockat.boutique"
    static let BLOCKAT_FACEBOOK_ID = "blockatboutique"
    static let BLOCKAT_SNAPCHAT_ID = "blockatboutique"
    static let BLOCKAT_WHATSAPP = "50888154"
    static let BLOCKAT_CONTACT_PHONE = "50888154"
    
    static let USER_NAME = "user_name"
    static let PASSWORD = "password"
    static let FULL_Name = "full_name"
    static let Email = "email"
    static let CONFIRM_PASSWORD = "confirm_password"
    static let PHONE_NUMBER = "mobile"
    static let OTP = "otp"
    static let PURPOSE_OF_REQUEST = "purpose_of_request"
}

struct ConstantAPI {
    //static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://ecapp.ml/api/v1/" : "https://ecapp.ml/api/v1/"
//    static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "http://devqslwa.azurewebsites.net/" : "http://devqslwa.azurewebsites.net/"

    static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://amiridiwan.applab.qa" : "https://amiridiwan.applab.qa"

    static let k_REQUEST_BOUNDARY:String = "---011000010111000001101001"
    static let k_REQUEST_TYPE_GET:String = "GET"
    static let k_REQUEST_TYPE_POST:String = "POST"
    
    
    /**************************** API URLS ********************************/
    //static let WEBSERVICE_USER_LOGIN             = "login"
    static let WEBSERVICE_USER_LOGIN             = "api/qsl/user/login"
    
    
//    static let WEBSERVICE_USER_REGISTRATION:String    = "registration"
//    static let WEBSERVICE_USER_REGISTRATION:String    = "api/qsl/user/registration"
    static let WEBSERVICE_USER_REGISTRATION:String = "/api/v1/register"
    static let WEBSERVICE_TERMS_SERVICE             = "masterData"
    static let WEBSERVICE_CLUBS_SERVICE             = "api/qsl/teams/list"
    static let WEBSERVICE_CLUBSPROFILE_SERVICE      = "api/club/profile"
    static let WEBSERVICE_COUNTRIES_SERVICE      = "/api/v1/countries"
//    static let WEBSERVICE_VERIFY_OTP             = "activeBySmsCode"
    static let WEBSERVICE_VERIFY_OTP             = "api/qsl/verify/otp"
    static let WEBSERVICE_RESEND_OTP             = "resendVerificationCode"
//    static let WEBSERVICE_RESET_PASSWORD             = "resetPassword"
    static let WEBSERVICE_RESET_PASSWORD             = "api/qsl/user/forgot-password"
    static let WEBSERVICE_SEND_RESET_PASSWORD_CODE             = "sendResetPasswordCode"
    static let WEBSERVICE_GET_COUNTRIES             = "countries"
    static let WEBSERVICE_GET_CATEGORIES            = "categories"
    static let WEBSERVICE_GET_SHOPS = "shops"
    static let WEBSERVICE_GET_SHOP_DETAILS = "ShopProducts"
    static let WEBSERVICE_GET_PRODUCT_DETAILS = "products"
    static let WEBSERVICE_GET_MY_PRODUCTS = "myProducts"
    static let WEBSERVICE_TOGGLE_PRODUCT_STATUS = "toggleProductStatus"
    static let WEBSERVICE_TOGGLE_FAVORITES = "favorites"
    static let WEBSERVICE_UPDATE_PROFILE             = "updateUserProfile"
    static let WEBSERVICE_USER_DETAILS             = "user"
    static let WEBSERVICE_GET_MY_SUBSCRIPTIONS      = "getMySubscriptions"
    static let WEBSERVICE_GET_NOTIFICATIONS = "getNotifications"
    static let WEBSERVICE_DELETE_NOTIFICATION = "deleteNotification"
    static let WEBSERVICE_GET_CATEGORY_PACKAGES     = "categoryPackages"
    static let WEBSERVICE_INITIAL_SUBSCRIPTION      = "initialSubscription"
    static let WEBSERVICE_PAYMENT_STATUS      = "paymentStatus"
    static let WEBSERVICE_LOGOUT             = "logout"
    static let WEBSERVICE_ADD_PRODUCT             = "createProduct"
    static let WEBSERVICE_CONTACT_US = "contactUs"
    static let WEBSERVICE_UPDATE_PRODUCT             = "updateProduct"
    static let WEBSERVICE_VERSION_CHECK            = "version-check"
    static let WEBSERVICE_ABOUT_US = "about"
    static let WEBSERVICE_SWITCH_PROFILE = "switchProfileType"
    static let WEBSERVICE_VENDOR_ACCEPT_TERMS             = "vendorAcceptContract"
    static let WEBSERVICE_CHECK_PROMOCODE = "checkMarketCode"
    static let WEBSERVICE_PRIVACY_POLICY = "about"  // TODO: - URL to be added, not yet provided (21-June-2022)
}

struct constantApiKey {
    
    //App Api Header - token
    static let KEY_APP_DEVICE_TOKEN     =  "device_token"
    static let KEY_API_TOKEN            =  "access_token"
    static let KEY_API_BEARER_TOKEN     =  "bearer_token"
    static let KEY_API_USER             =  "user"
}

struct ConstantErrorString {
    static let k_CHECK_INTERNET             = "Please check the internet availability"
    static let k_ERROR                      = "An error occurred, please try again later"
    static let k_404                        = "Details not found. Pleaes try after some time"
    //AppController
    static let k_NO_INTERNET                = "No Internet, Please check"
}

struct ConstantDateFormat {
    static let dd                           = "dd"
    static let MM                           = "MM"
    static let MMM                          = "MMM"
    static let yyyy                         = "yyyy"
    static let EEE                          = "EEE"
    
    static let dd_MMM                       = "dd MMM"
    
    static let dd_MMM_yyyy                  = "dd MMM yyyy"
    static let dd_MM_yyyy_slashJoined       = "dd/MM/yyyy"
    static let yyyy_MM_dd                   = "yyyy-MM-dd"
    
    static let yyyy_MM_dd_HH_mm_ss          = "yyyy_MM_dd_HH_mm_ss"
    static let YYYY_MM_dd_HH_mm_ssWithColon = "YYYY-MM-dd HH:mm:ss"
    static let EEEE_dd_MMMM_YYYY            = "EEEE-dd-MMMM-YYYY"
}

struct ConstantValues {
    //static let k_ACTIVITY_LEVEL_SCALE_VERYACTIVE:Float =  1.9
    
}

class Config {
    static var isAppDevelopment:Bool {
        return true 
    }
    
    static var renderLable:Bool {
        get {
            if (UIDevice.current.identifierForVendor != nil){
                return true
            }else{
                return false
            }
        }
    }
}

 
