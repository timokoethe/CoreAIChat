import Foundation

enum ModelState {
    case missingResources
    case unloaded
    case loading
    case ready
    case failed(Error)
}
