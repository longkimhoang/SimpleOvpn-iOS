import OHHTTPStubs
import OHHTTPStubsSwift

public enum SimpleOvpnStubs {
    public static func loadStubs() {
        stub(condition: isHost("www.vpngate.net") && isPath("/api/iphone")) { _ in
            let stubPath = OHPathForFileInBundle("vpngate_response.txt", Bundle.module)
            return fixture(
                filePath: stubPath!,
                headers: [
                    "Content-Type": "text/plain; charset=utf-8"
                ])
        }
    }

    public static func url(forStubNamed stubName: String) -> URL {
        guard let path = OHPathForFileInBundle(stubName, Bundle.module) else {
            fatalError("No stub found with name \(stubName)")
        }

        return URL(fileURLWithPath: path)
    }
}
