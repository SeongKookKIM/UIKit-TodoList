
import Foundation




struct Todo: Identifiable, Codable {
    let id: UUID
    let title: String
    let content: String
    let date: Date?
    var isDone: Bool
}


