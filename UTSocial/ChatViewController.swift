//
//  ChatViewController.swift
//  
//
//  Created by 谢阳欣雨 on 5/12/19.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, MessageInputBarDelegate {
    
    var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var tapGesture: UITapGestureRecognizer!
    
    var posts = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()
    
    let chatBar = MessageInputBar()
    
    override var inputAccessoryView: UIView?{
        return chatBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        //Create the comment
        let chat = PFObject(className: "Chat")
        
        chat["ChatContent"] = text
        
        chat.saveInBackground { (success, error) in
            if success{
                print("Chat saved!")
            }else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        myTableView.reloadData()
        
        chatBar.inputTextView.text = nil
        becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        chatBar.delegate = self
        
        myTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "chatCell")
        myTableView.separatorStyle = .none
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEdit(_:)))
        myTableView.addGestureRecognizer(tapGesture)
        
        myRefreshControl.addTarget(self, action: #selector(queryData), for: .valueChanged)
        myTableView.refreshControl = myRefreshControl
        
        myTableView.keyboardDismissMode = .interactive
        
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(queryData), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.queryData()
    }
    
    @objc func queryData(){
        let query = PFQuery(className: "Chat")
        query.includeKeys(["ChatContent"])
        query.order(byDescending: "createdAt")
        query.limit = 20
        
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.myTableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }else {
                print("error!")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as! ChatTableViewCell
        let post = posts[indexPath.row]
        cell.messageLabel.text = (post["ChatContent"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        myTableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    @objc func endEdit(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        }else{
            view.frame.origin.y = 0
        }
    }
    
}
