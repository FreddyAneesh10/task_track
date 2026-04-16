class DashboardStats {
  final int departments;
  final int services;
  final int projects;
  final int clients;

  const DashboardStats({
    required this.departments,
    required this.services,
    required this.projects,
    required this.clients,
  });

  const DashboardStats.empty()
      : departments = 0,
        services = 0,
        projects = 0,
        clients = 0;
}
