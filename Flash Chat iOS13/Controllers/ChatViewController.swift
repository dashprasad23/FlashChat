//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
      Message(sender: "a@b.com", body: "Hay")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton  = true
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()

    }
    
    func loadMessages() {
        print("Load message called")
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener( {(querySnapshot, error) in
            
            if let e = error {
                print(e, "Reeoe")
            } else {
                self.messages = []
                if let snapshotsDocuments = querySnapshot?.documents {
                    
                    for doc in snapshotsDocuments {
                        let data = doc.data()
                        
                        if  let sendr = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String  {
                            self.messages.append(Message(sender: sendr, body: body))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
        })
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSendr = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSendr, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970], completion: {(error) in
                if let e = error {
                    print(e)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    print("Successfully hit save")
                }
            })
        }
        
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

//MARK: - UITableViewDatasource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youAvatar.isHidden = true
            cell.meAvatar.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
            
        } else {
            cell.meAvatar.isHidden = true
            cell.youAvatar.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    
}
