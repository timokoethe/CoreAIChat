import Foundation

enum ModelState {
    case missingResources
    case missingTokenizer
    case unloaded
    case loading
    case ready
    case failed(Error)
}
