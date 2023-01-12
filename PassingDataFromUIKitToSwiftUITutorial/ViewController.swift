//
//  ViewController.swift
//  PassingDataFromUIKitToSwiftUITutorial
//
//  Created by Leonardo Maia Pugliese on 09/01/2023.
//

import UIKit
import SwiftUI

struct User {
    var id: String = UUID().uuidString
}

class ViewController: UIViewController {
    private var usersViewModel = UserViewModel()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //                configureUserView()
        //        configureUserViewToSendDataByInitializer()
        //        configureUserViewToUpdateWithUserDefaults()
        //        configureUserViewToUpdateWithEnvironmentObject()
        configureUserViewToUpdateWitNotificationCenter()
        
        timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak usersViewModel] _ in
            usersViewModel?.generateUser()
        })
    }
    
    //
    //        private func configureUserView() {
    //            usersViewModel.generateUser()
    //            let userViewController = UIHostingController(rootView: UserView(users: usersViewModel.users)) //the problem is that we always have to update the view manually
    //            addChild(userViewController)
    //            userViewController.view.translatesAutoresizingMaskIntoConstraints = false
    //            view.addSubview(userViewController.view)
    //            userViewController.didMove(toParent: self)
    //
    //            NSLayoutConstraint.activate([
    //                userViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //                userViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    //            ])
    //        }
    
    //    private func configureUserViewToSendDataByInitializer() {
    //        let userViewController = UIHostingController(rootView: UserView(userViewModel: usersViewModel))
    //        addChild(userViewController)
    //        userViewController.view.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(userViewController.view)
    //        userViewController.didMove(toParent: self)
    //
    //        NSLayoutConstraint.activate([
    //            userViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            userViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    //            userViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
    //        ])
    //    }
    //
    //    private func configureUserViewToUpdateWithUserDefaults() {
    //        let userViewController = UIHostingController(rootView: UserView())
    //        addChild(userViewController)
    //        userViewController.view.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(userViewController.view)
    //        userViewController.didMove(toParent: self)
    //
    //        NSLayoutConstraint.activate([
    //            userViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            userViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    //            userViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
    //        ])
    //
    //    }
    
    //    private func configureUserViewToUpdateWithEnvironmentObject() {
    //        let userView = UserView().environmentObject(usersViewModel)
    //
    //        let userViewController = UIHostingController(rootView: userView)
    //        addChild(userViewController)
    //        userViewController.view.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(userViewController.view)
    //        userViewController.didMove(toParent: self)
    //
    //        NSLayoutConstraint.activate([
    //            userViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            userViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    //            userViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
    //        ])
    //
    //    }
    
    private func configureUserViewToUpdateWitNotificationCenter() {
        let userView = UserView()
        
        let userViewController = UIHostingController(rootView: userView)
        addChild(userViewController)
        userViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userViewController.view)
        userViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            userViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
    }
}


//class UserViewModel {
//    private(set) var users: [User] = []
//
//    @discardableResult
//    func generateUser() -> User {
//        let newUser = User()
//        users.append(newUser)
//        return newUser
//    }
//}
//
//
//
//struct UserView: View {
//
//    let users: [User]
//
//    var body: some View {
//        VStack {
//            Text("User name: \(users.first?.id ?? "")")
//                .minimumScaleFactor(0.5)
//                .lineLimit(2)
//            Text("User Count: \(users.count)")
//        }
//    }
//}
// ------ ------ ------ ------ ------ ------ ------ ------


//class UserViewModel: ObservableObject { // add conformance to ObservableObject
//    @Published private(set) var users: [User] = [] // add published to this var
//
//    @discardableResult
//    func generateUser() -> User {
//        let newUser = User()
//        print(newUser)
//        users.append(newUser)
//        return newUser
//    }
//}
//
//struct UserView: View {
//    @ObservedObject var userViewModel: UserViewModel // annotate with ObservedObject
//
//    var body: some View {
//        VStack {
//            Text("User name: \(userViewModel.users.first?.id ?? "")")
//                .minimumScaleFactor(0.5)
//                .lineLimit(2)
//            Text("User Count: \(userViewModel.users.count)")
//        }
//    }
//}
// ------ ------ ------ ------ ------ ------ ------ ------


// using User Defaults to update values in the SwiftUI view
//class UserViewModel: ObservableObject {
//    private(set) var users: [User] = []
//
//    @discardableResult
//    func generateUser() -> User {
//        let newUser = User()
//        print(newUser)
//        users.append(newUser)
//
//        UserDefaults.standard.set(newUser.id, forKey: "userKeyID")
//
//        return newUser
//    }
//}
//
//struct UserView: View {
//    @AppStorage("userKeyID") var user = ""
//
//    var body: some View {
//        VStack {
//            Text("User name: \(user)")
//                .minimumScaleFactor(0.5)
//                .lineLimit(2)
//        }
//    }
//}


// ---- -- -- - - -- -- - - -- - --- ---- ---- - -- -
//
//class UserViewModel: ObservableObject { // add conformance to ObservableObject
//    @Published private(set) var users: [User] = [] // add published to this var
//
//    @discardableResult
//    func generateUser() -> User {
//        let newUser = User()
//        print(newUser)
//        users.append(newUser)
//        return newUser
//    }
//}
//
//struct UserView: View {
//    @EnvironmentObject var userViewModel: UserViewModel // add environmentObject to this variable
//
//    var body: some View {
//        VStack {
//            Text("User name: \(userViewModel.users.first?.id ?? "")")
//                .minimumScaleFactor(0.5)
//                .lineLimit(2)
//            Text("User Count: \(userViewModel.users.count)")
//        }
//    }
//}
// ---- -- -- - - -- -- - - -- - --- ---- ---- - -- -


//notification center example
class UserViewModel: ObservableObject { // add conformance to ObservableObject
    @Published private(set) var users: [User] = [] // add published to this var
    
    @discardableResult
    func generateUser() -> User {
        let newUser = User()
        print(newUser)
        users.append(newUser)
        NotificationCenter.default.post(name: NSNotification.Name("sendUsers"), object: self, userInfo: ["users": users])
        return newUser
    }
}

struct UserView: View {
    let usersPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("sendUsers"))
    
    @State var users = [User]()
    
    var body: some View {
        VStack {
            Text("User name: \(users.first?.id ?? "")")
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            Text("User Count: \(users.count)")
        }.onReceive(usersPublisher) { output in
            guard let users = output.userInfo?["users"] as? [User] else {
                print("fail")
                return
            }
            print("success \(users)")
            self.users = users
        }
    }
}
