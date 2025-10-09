#!/bin/bash

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
sleep 15

# Deploy the DACPAC
/opt/mssql-tools/bin/sqlpackage /Action:Publish \
    /SourceFile:/var/opt/mssql/dacpac/JustOneBio.Database.dacpac \
    /TargetServerName:localhost \
    /TargetDatabaseName:RandomTemporary \
    /TargetUser:sa \
    /TargetPassword:JustOneBioBestPassword123@

echo "DACPAC deployment completed."

# Keep the container running
tail -f /dev/null
