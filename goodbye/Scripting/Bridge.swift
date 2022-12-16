//
//  Bridge.swift
//  goodbye
//
//  Created by Brian Michel on 12/16/22.
//

import Foundation
import ScriptingBridge

final class Bridge {
    private let chromeApplication: ChromeApplication

    var tabs: [ChromeTab]? {
        let windows = chromeApplication.windows?().compactMap({ $0 as? ChromeWindow })
        let tabs = windows?.compactMap({ window in
            window.tabs?().compactMap({ $0 as? ChromeTab })
        })

        return tabs?.flatMap({$0})
    }

    init() {
        self.chromeApplication = SBApplication(bundleIdentifier: "com.google.Chrome")!
    }

    func closeMeets() {
        tabs?
            .filter({$0.URL?.hasPrefix("https://meet.google.com") ?? false})
            .forEach({ tab in
                tab.close?()
            })
    }

    func printAllTabs() {
        let windows = chromeApplication.windows?().compactMap({ $0 as? ChromeWindow })
        let tabs = windows?.compactMap({ window in
            window.tabs?().compactMap({ $0 as? ChromeTab })
        })

        let flattened = tabs?.flatMap({$0})

        for tab in flattened! {
            print("Tab: \(String(describing: tab.URL))")
        }
    }
}
