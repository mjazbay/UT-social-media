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
    
    @IBOutlet var tableView: UITableView!
    
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
                print("Error: \(error?.localizedDescription)")
            }
        }
        tableView.reloadData()
        
        chatBar.inputTextView.text = nil
        becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        chatBar.delegate = self
        
        myRefreshControl.addTarget(self, action: #selector(queryData), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.keyboardDismissMode = .interactive
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.queryData()
    }
    
    @objc func queryData(){
        let query = PFQuery(className: "Chat")
        query.includeKeys(["ChatContent"])
        query.order(byAscending: "Time")
        query.limit = 20
        
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        let post = posts[indexPath.row]
        cell.messageLabel.text = post["ChatContent"] as! String
        return cell
    }
    
    @IBAction func endEdit(_ sender: Any) {
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
