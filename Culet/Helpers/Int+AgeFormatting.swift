//

import Foundation

extension Int {
  var yearsString: String {
    let mod10 = self % 10
    let mod100 = self % 100
    
    let word: String
    if mod100 >= 11 && mod100 <= 19 {
      word = "лет"
    } else {
      switch mod10 {
      case 1: word = "год"
      case 2, 3, 4: word = "года"
      default: word = "лет"
      }
    }
    return "\(self) \(word)"
  }
}
