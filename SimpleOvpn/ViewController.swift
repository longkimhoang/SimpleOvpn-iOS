//
//  ViewController.swift
//  SimpleOvpn
//
//  Created by Kim Long on 22/08/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()  // Do any additional setup after loading the view.
        let controller = VpnGateAPIController()
        Task {
            let servers = try await controller.fetchVpnServers()
            print(servers.count)
        }
    }

}
