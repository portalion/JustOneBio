#!/bin/bash
set -e

/opt/mssql/bin/sqlservr &

echo "Waiting for SQL Server to start..."
until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -C -Q "SELECT 1" > /dev/null 2>&1; do
  sleep 1
  echo "Still Waiting for SQL Server to be available..."
done

echo "Deploying DACPAC..."
/opt/sqlpackage/sqlpackage /Action:Publish \
  /SourceFile:/var/opt/mssql/JustOneBioDB.dacpac \
  /TargetServerName:localhost,1433 \
  /TargetDatabaseName:${DB_NAME} \
  /TargetUser:sa \
  /TargetPassword:${SA_PASSWORD} \
  /SourceTrustServerCertificate:True \
  /TargetTrustServerCertificate:True \
  /Quiet

echo "DACPAC deployment complete."
wait
