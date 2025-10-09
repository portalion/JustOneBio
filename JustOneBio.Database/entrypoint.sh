#!/bin/bash
set -e

/opt/mssql/bin/sqlservr &

echo "Waiting for SQL Server to start..."
sleep 10
# for i in {1..30}; do
#   /opt/mssql-tools/bin/sqlcmd -S localhost -p 1433:1433 -U sa -P "JustOneBioBestPassword123@" -Q "SELECT 1" &> /dev/null && break
#   echo "   SQL Server not ready yet... ($i/30)"
#   sleep 2
# done

echo "Deploying DACPAC..."
/opt/sqlpackage/sqlpackage /Action:Publish \
  /SourceFile:/var/opt/mssql/JustOneBioDB.dacpac \
  /TargetServerName:localhost,1433 \
  /TargetDatabaseName:justonebio_main \
  /TargetUser:sa \
  /TargetPassword:JustOneBioBestPassword123@ \
  /SourceTrustServerCertificate:True \
  /TargetTrustServerCertificate:True \
  /Quiet

echo "DACPAC deployment complete."
wait
