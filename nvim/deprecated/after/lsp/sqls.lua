return {
	settings = {
		sqls = {
			connections = {
				{
					driver = "mysql",
					dataSourceName = "root:root@tcp(127.0.0.1:3306)/database",
					alias = "local-container-db-mysql",
				},
				{
					driver = "postgresql",
					dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=database sslmode=disable",
					alias = "local-container-db-postgres",
				},
			},
		},
	},
}
