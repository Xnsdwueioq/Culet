//

extension String {
  var maskedString: String {
    String(
      self.map { $0.isNumber ? "*" : $0 }
    )
  }
}
