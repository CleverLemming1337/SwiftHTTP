import SwiftHTTP


do {
    try startServer()
}
catch {
    print("Error: \(error.localizedDescription)")
}
