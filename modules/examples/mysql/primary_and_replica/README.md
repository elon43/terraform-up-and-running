This example calls the mysql module twice to deploy a mysql database with a replica.  On the first mysql module call, backup_retention_period = 1.  On the second mysql module call, replicate_source_db = module.mysql_primary.arn.

Run the following two command to set the environment variables for db_username
and db_password.

export TF_VAR_db_username=stefant
export TF_VAR_db_password=stefantstefant
