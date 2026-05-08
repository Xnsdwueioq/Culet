struct PatientCaptionView: View {
  var body: some View {
    HStack {
      Text("Женщина")
      Circle().frame(width: 3)
      Text("20 лет")
      Circle().frame(width: 3)
      Text("24.07.2006")
    }
    .foregroundStyle(.secondary)
    .font(.footnote)
  }
}