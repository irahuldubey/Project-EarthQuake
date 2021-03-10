//
//  File.swift
//  
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import Network

// NWPathMonitor is another approach to see the network connection what I observed the immediate change in the network gives me the old network type in the closure and not the updated one, however if I launch for the next time I would get the updated network type. This wont work if user has disabled the network and want to see a different webview index by going back and coming to the webview again in the detail view section. Haven't tried on device but this approach should also work

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

public class NetworkMonitor {
    
    static public let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    public var isNetworkConnectionEnabled: Bool = false
    public var connectionType: ConnectionType = .unknown
 
    // If we want to subscribe for the network connection
    public var currentNetworkStatus: NetworkStatus = .unavailable {
        didSet {
            if currentNetworkStatus != oldValue {
                NotificationCenter.default.post(name: Notification.Name("NetworkChanged"), object: currentNetworkStatus)
            }
        }
    }
    
    public init(withMonitor pathMonitor: NWPathMonitor = NWPathMonitor()) {
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
 
    public func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
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
