output "cluster_id" {
  value       = yandex_mdb_mysql_cluster.test.id
  description = "ID созданного кластера MySQL"
}
