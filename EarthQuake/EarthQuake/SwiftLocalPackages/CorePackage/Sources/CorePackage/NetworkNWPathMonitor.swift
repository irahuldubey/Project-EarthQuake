//
//  File.swift
//  
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import Network

public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}

public enum NetworkStatus {
    case unavailable
    case available
}

@available(iOS 12.0, *)
public class NetworkNWPathMonitor {
    
    static public let shared = NetworkNWPathMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    public var isNetworkConnectionEnabled: Bool = true
    public var connectionType: ConnectionType = .unknown
 
    // If we want to subscribe for the network connection
    private var currentNetworkStatus: NetworkStatus = .unavailable {
        didSet {
            if currentNetworkStatus != oldValue {
                NotificationCenter.default.post(name: Notification.Name("NetworkChanged"), object: currentNetworkStatus)
            }
        }
    }
    
    private init(withMonitor pathMonitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = pathMonitor
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    public func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else {
                return
            }
            if path.status == .satisfied {
                strongSelf.currentNetworkStatus = .available
            } else {
                strongSelf.currentNetworkStatus = .unavailable
            }
            strongSelf.isNetworkConnectionEnabled = path.status == .satisfied
            strongSelf.connectionType = strongSelf.checkConnectionTypeForPath(path)
        }
    }
 
    public func stopMonitoring() {
        self.monitor.cancel()
    }
 
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        return .unknown
    }
}
