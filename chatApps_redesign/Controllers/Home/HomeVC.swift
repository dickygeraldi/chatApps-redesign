//
//  HomeVC.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var topicTableView: UITableView!
    var dataTopic: [Topic] = []
    
    var authData = AuthDataCore()
    var homeCoreData = HomeDataCore()
    
    func initUI() {
        topicTableView.delegate = self
        topicTableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        dataTopic = retrieveDataTopic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataTopic = retrieveDataTopic()
        
        topicTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    @IBAction func unwindTopic(for unwindSegue: UIStoryboardSegue) {
        topicTableView.reloadData()
    }
    
    func retrieveDataTopic() -> ([Topic]) {
        let temp = homeCoreData.retrieveTopic()
        
        print(temp)
        return temp
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChatVC, let topicIndex = topicTableView.indexPathForSelectedRow?.row {
            
            let users = authData.retrieveData(entity: "Users")
            
            destination.dataTopic = dataTopic[topicIndex].headline
            destination.username = users.username
            destination.topicId = dataTopic[topicIndex].idData
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let topicList = dataTopic[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicTableViewCell
        
        cell.setTopic(topic: topicList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let data = dataTopic[indexPath.row]
            
            dataTopic.remove(at: indexPath.row)
            
            homeCoreData.deleteData(entity: "DataTopics", uniqueId: data.idData)
            topicTableView.beginUpdates()
            topicTableView.deleteRows(at: [indexPath], with: .automatic)
            topicTableView.endUpdates()
        }
    }
}
