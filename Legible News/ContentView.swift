import SwiftUI
import WebKit
import Turbo
import NavigationBackport

struct TurboNavigationStack: View {
    
    @StateObject var wrapper = SessionWrapper()
    
    let initialUrl: String

    var body: some View {
        NBNavigationStack(path: $wrapper.path) {
            TurboNavigationView(url: initialUrl, sessionWrapper: wrapper)
            .nbNavigationDestination(for: String.self) { url in
                return TurboNavigationView(url: url, sessionWrapper: wrapper)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            TurboNavigationStack(initialUrl: "https://legiblenews.com/")
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Today")
                }
            TurboNavigationStack(initialUrl: "https://legiblenews.com/week")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Week")
                }
            TurboNavigationStack(initialUrl: "https://legiblenews.com/archives")
            .tabItem {
                Image(systemName: "clock")
                Text("Time Machine")
            }
        }
    }
}

struct TurboNavigationView: View {
    let url: String
    
    @ObservedObject var sessionWrapper: SessionWrapper

    var body: some View {
        if sessionWrapper.session != nil {
            TurboView(session: sessionWrapper.session, url: url)
            .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Loading...")
        }
    }
}

struct TurboView: UIViewControllerRepresentable {
    let session: Session
    let url: String

    func makeUIViewController(context: Context) -> VisitableViewController {
        let viewController = VisitableViewController(url: URL(string: url)!)
        session.visit(viewController)
        return viewController
    }

    func updateUIViewController(_ visitableViewController: VisitableViewController, context: Context) {
    }
}


class SessionWrapper: ObservableObject, SessionDelegate {
    
    @Published var path: [String] = []
    
    @Published var session: Session!

    private static var sharedProcessPool = WKProcessPool()
    
//    private var pathConfiguration = PathConfiguration(sources: [
//        .file(Bundle.main.url(forResource: "path-configuration", withExtension: "json")!)
//    ])
    
    init() {
        self.session = makeSession()
    }
    
    func navigate(url: String) {
        self.path.append(url)
    }
    
    func makeSession() -> Session {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "Turbo iOS"
        configuration.processPool = Self.sharedProcessPool

        let session = Session(webViewConfiguration: configuration)
        session.webView.allowsLinkPreview = false
//        session.pathConfiguration = self.pathConfiguration
        
        session.delegate = self

        return session
    }
    
    func session(_ session: Turbo.Session, didProposeVisit proposal: Turbo.VisitProposal) {
        print(proposal)
        self.navigate(url: proposal.url.absoluteString)
    }
    
    func sessionWebViewProcessDidTerminate(_ session: Turbo.Session) {
    }
    
    func session(_ session: Turbo.Session, didFailRequestForVisitable visitable: Turbo.Visitable, error: Error) {
    }
    
}
