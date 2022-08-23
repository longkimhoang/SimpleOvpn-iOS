// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func formatSourceFilesLane() {
        desc("Format source files")
        let formatDirectories = ["SimpleOvpn", "SimpleOvpnTests", "SimpleOvpnUITests"]
        let formatScript = """
            if which swift-format > /dev/null; then
                swift-format -i -p -r \(formatDirectories.joined(separator: " "))
            fi
            """
        sh(command: formatScript)
    }
}
