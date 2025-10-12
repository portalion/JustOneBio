# JustOneBio

A full-stack application built with **ASP.NET Core**, **React**, and a **SQL Server database** running in Docker.  
The solution uses database containerization for consistent development environments.  
The database schema is deployed using a `.dacpac` file that must be **manually published** after the first build or when schema changes occur.

---

## Project Structure

```
JustOneBio/
├── JustOneBio.Server/         # ASP.NET Core backend
├── JustOneBio.Client/         # React frontend
├── JustOneBio.Database/       # SQL project (produces .dacpac)
├── docker-compose.yml         # Defines app + DB containers
├── dockerfile.database        # Custom SQL Server image with dacpac tools
├── .env                       # File with needed environment variables (password etc)
├── scripts/
│   └── entrypoint.sh          # Container startup script for DB deployment
└── Dacpac/
    └── JustOneBio.Database.dacpac
```

---

## Prerequisites

Before running the application, make sure you have:

- **Docker Desktop** (with Docker Compose)
- **Visual Studio 2022** or **VS Code**
- **.NET 8 SDK**
- **Node.js (v18+)**
- **SQLPackage CLI** (optional, for manual DACPAC deployment outside Docker)

---

## Setup Instructions

### Clone the repository

```bash
git clone https://github.com/your-org/JustOneBio.git
cd JustOneBio
```

### Configure environment

Create `.env` file and adjust any required variables:

```
SA_PASSWORD=JustOneBioBestPassword123@
DB_NAME=JustOneBioDB
```

---

## Running the application

### Build and start containers

You can start everything using Docker Compose:

```bash
docker-compose up --build
```

This will:

- Start the **SQL Server container (`JustOneBioDB`)**
- Start the **ASP.NET Core backend container (`JustOneBioServer`)**
- Start the **React client**

## Updating the Database

Whenever you change the SQL project (`.sqlproj`) and rebuild it:

1. Ensure the `.dacpac` is re-generated (`Build` → `Rebuild` in Visual Studio).
2. Publish database into container for example via visual studio with this example publishing profile:

```
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="Current" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <IncludeCompositeObjects>True</IncludeCompositeObjects>
    <TargetDatabaseName>justonebio_main</TargetDatabaseName>
    <DeployScriptFileName>JustOneBioDB</DeployScriptFileName>
    <ProfileVersionNumber>1</ProfileVersionNumber>
    <TargetConnectionString>Data Source=localhost;Persist Security Info=True;User ID=sa;Pooling=False;Multiple Active Result Sets=False;Connect Timeout=60;Encrypt=True;Trust Server Certificate=True;Command Timeout=0</TargetConnectionString>
    <BlockWhenDriftDetected>False</BlockWhenDriftDetected>
    <RegisterDataTierApplication>False</RegisterDataTierApplication>
  </PropertyGroup>
</Project>
```

If the database structure gets corrupted or you want a clean start:

```bash
docker-compose down -v
docker-compose up --build
```

This recreates the database volume and redeploys the schema.

---

## Developer Workflow Summary

| Task                     | Command or Action                                     |
| ------------------------ | ----------------------------------------------------- |
| Build backend & frontend | `docker-compose up --build`                           |
| Build only backend       | Build `JustOneBio.Server` in Visual Studio            |
| Build database           | Build `JustOneBio.Database` (produces `.dacpac`)      |
| Deploy database          | Run `sqlpackage` (manual step)                        |
| Stop containers          | `docker-compose down`                                 |
| Reset everything         | `docker-compose down -v && docker-compose up --build` |

---

## Notes

- The SQL Server container uses a persistent volume `dbdata` to retain data between runs.
- The DACPAC deployment process updates the schema **non-destructively** (it preserves data unless schema conflicts occur).
- For development speed, you can mount your `Dacpac/` folder as a Docker volume and run `sqlpackage` from your host or inside the container.

---

## Running Frontend

To run frontend app you need to run following command:

```
npm run dev
```
