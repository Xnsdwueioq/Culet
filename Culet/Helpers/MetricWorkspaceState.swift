//

enum MetricWorkspaceState {
  case empty
  case creating
  case viewing(ReceptionMetric)
}
