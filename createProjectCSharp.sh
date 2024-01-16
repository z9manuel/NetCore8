#!/bin/sh

# Reemplace los valores de Company y Application por los de su proyecto
Company="CongresoGTO"                   # Nombre de la empresa
Application="Recursos"           # Nombre de la aplicacion

echo "\n###########################################"
echo "INICIANDO CREACION DE PROYECTO C#"
echo "Creando proyecto $Application para $Company"
mkdir "$Company.$Application"
cd "$Company.$Application"

echo "\n###########################################"
echo "Creando Solucion"
dotnet new sln
echo "Creando archivo GitIgnore"
dotnet new gitignore
mkdir src
cd src
mkdir API Common Core Infraestructure
echo "Solucion creada \n"

echo "\n###########################################"
echo "Creando proyecto API"
cd API
dotnet new webapi --name "$Company.$Application.Api"
echo "Proyecto API creado \n"

echo "\n###########################################"
echo "Creando proyecto Application"
cd ../Core
mkdir Application Domain
cd Application
dotnet new classlib --name "$Company.$Application.Application"
mkdir "$Company.$Application.Application/Interfaces"
echo "Proyecto Application creado \n"

echo "\n###########################################"
echo "Creando proyecto Domain"
cd ../Domain
dotnet new classlib --name "$Company.$Application.Domain"
mkdir "$Company.$Application.Domain/Entities"
echo "Proyecto Domain creado \n"

echo "\n###########################################"
echo "Creando proyecto Persistence"
cd ../../Infraestructure
mkdir Persistence External
cd Persistence
dotnet new classlib --name "$Company.$Application.Persistence"
mkdir "$Company.$Application.Persistence/DataBase"
mkdir "$Company.$Application.Persistence/Configuration"
echo "Proyecto Persistence creado \n"

echo "\n###########################################"
echo "Creando proyecto External"
cd ../External
dotnet new classlib --name "$Company.$Application.External"
echo "Proyecto External creado \n"

echo "\n###########################################"
echo "Creando proyecto Common"
cd ../../Common
dotnet new classlib --name "$Company.$Application.Common"
echo "Proyecto Common creado \n"

echo "\n###########################################"
echo "Agregando proyectos a la solucion"
cd ../..
dotnet sln add "src/API/$Company.$Application.Api"
dotnet sln add "src/Core/Application/$Company.$Application.Application"
dotnet sln add "src/Core/Domain/$Company.$Application.Domain"
dotnet sln add "src/Infraestructure/Persistence/$Company.$Application.Persistence"
dotnet sln add "src/Infraestructure/External/$Company.$Application.External"
dotnet sln add "src/Common/$Company.$Application.Common"
echo "Proyectos agregados a la solucion \n"

echo "\n###########################################"
echo "Agregando referencias a los proyectos"
cd "src/Infraestructure/External/$Company.$Application.External"
echo "Agregando referencias a External"
dotnet add reference "../../../Core/Domain/$Company.$Application.Domain/$Company.$Application.Domain.csproj"
dotnet add reference "../../../Core/Application/$Company.$Application.Application/$Company.$Application.Application.csproj"
echo "Referencias agregadas a External"

echo "\n###########################################"
echo "Agregando referencias a Persistence"
cd ../../../..
cd "src/Infraestructure/Persistence/$Company.$Application.Persistence"
dotnet add reference "../../../Core/Domain/$Company.$Application.Domain/$Company.$Application.Domain.csproj"
dotnet add reference "../../../Core/Application/$Company.$Application.Application/$Company.$Application.Application.csproj"
echo "Referencias agregadas a Persistence"

echo "\n###########################################"
echo "Agregando referencias a Application"
cd ../../../..
cd "src/Core/Application/$Company.$Application.Application"
dotnet add reference "../../../Core/Domain/$Company.$Application.Domain/$Company.$Application.Domain.csproj"
echo "Referencias agregadas a Application"

echo "\n###########################################"
echo "Agregando referencias a Api"
cd ../../../..
cd "src/API/$Company.$Application.Api"
dotnet add reference "../../Core/Application/$Company.$Application.Application/$Company.$Application.Application.csproj"
echo "Referencias agregadas a Api"

echo "\n###########################################"
echo "Eliminando clases inecesarias..."
cd ../../..
rm "src/Core/Application/$Company.$Application.Application/Class1.cs"
rm "src/Core/Domain/$Company.$Application.Domain/Class1.cs"
rm "src/Infraestructure/Persistence/$Company.$Application.Persistence/Class1.cs"
rm "src/Infraestructure/External/$Company.$Application.External/Class1.cs"
rm "src/Common/$Company.$Application.Common/Class1.cs"
echo "Clases inecesarias eliminadas \n"

echo "\n###########################################"
echo "Generando inyeccion de dependencias..."

touch "src/API/$Company.$Application.Api/DependencyInjectionService.cs"
touch "src/Core/Application/$Company.$Application.Application/DependencyInjectionService.cs"
touch "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
touch "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
touch "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"

echo "using Microsoft.Extensions.DependencyInjection;" >> "src/API/$Company.$Application.Api/DependencyInjectionService.cs"
echo "namespace $Company.$Application.Api \n{" >> "src/API/$Company.$Application.Api/DependencyInjectionService.cs"
echo "\tpublic static class DependencyInjectionService \n\t{" >> "src/API/$Company.$Application.Api/DependencyInjectionService.cs"
echo "\t\tpublic static IServiceCollection AddWebApi (this IServiceCollection services) \n\t\t{" >> "src/API/$Company.$Application.Api/DependencyInjectionService.cs"
echo "\t\t\treturn services; \n\t\t}\n\t}\n}" >> "src/API/$Company.$Application.Api/DependencyInjectionService.cs"

echo "using Microsoft.Extensions.DependencyInjection;" >> "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"
echo "namespace $Company.$Application.Common \n{" >> "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"
echo "\tpublic static class DependencyInjectionService \n\t{" >> "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"
echo "\t\tpublic static IServiceCollection AddCommon (this IServiceCollection services) \n\t\t{" >> "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"
echo "\t\t\treturn services; \n\t\t}\n\t}\n}" >> "src/Common/$Company.$Application.Common/DependencyInjectionService.cs"

echo "using Microsoft.Extensions.DependencyInjection;" >> "src/Core/$Application/$Company.$Application.Application/DependencyInjectionService.cs"
echo "namespace $Company.$Application.Application \n{" >> "src/Core/$Application/$Company.$Application.Application/DependencyInjectionService.cs"
echo "\tpublic static class DependencyInjectionService \n\t{" >> "src/Core/$Application/$Company.$Application.Application/DependencyInjectionService.cs"
echo "\t\tpublic static IServiceCollection AddApplication (this IServiceCollection services) \n\t\t{" >> "src/Core/$Application/$Company.$Application.Application/DependencyInjectionService.cs"
echo "\t\t\treturn services; \n\t\t}\n\t}\n}" >> "src/Core/$Application/$Company.$Application.Application/DependencyInjectionService.cs"

echo "using Microsoft.Extensions.DependencyInjection;" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
echo "using Microsoft.Extensions.Configuration;" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
echo "namespace $Company.$Application.External \n{" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
echo "\tpublic static class DependencyInjectionService \n\t{" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
echo "\t\tpublic static IServiceCollection AddExternal (this IServiceCollection services, IConfiguration configuration) \n\t\t{" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"
echo "\t\t\treturn services; \n\t\t}\n\t}\n}" >> "src/Infraestructure/External/$Company.$Application.External/DependencyInjectionService.cs"

echo "using Microsoft.Extensions.DependencyInjection;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "using Microsoft.Extensions.Configuration;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "using Microsoft.EntityFrameworkCore;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "using $Company.$Application.Application.Interfaces;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "using $Company.$Application.Persistence.DataBase;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "namespace $Company.$Application.Persistence \n{" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\tpublic static class DependencyInjectionService \n\t{" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\t\tpublic static IServiceCollection AddPersistence (this IServiceCollection services, IConfiguration configuration) \n\t\t{" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\t\t\tservices.AddDbContext<DataBaseServive>(options =>" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\t\t\t\toptions.UseSqlServer(configuration[\"SQLConnectionString\"]));" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\t\t\tservices.AddScoped<IDataBaseService, DatabaseService>();" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"
echo "\t\t\treturn services; \n\t\t}\n\t}\n}" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DependencyInjectionService.cs"

echo "Inyeccion de dependencias generada \n"

echo "\n###########################################"
echo "Generando archivo de configuracion $Company.$Application.Persistence/DataBase/DataBaseService.cs..."
echo "using Microsoft.EntityFrameworkCore;" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DataBase/DataBaseService.cs"
echo "namespace $Company.$Application.Persistence.DataBase \n{" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DataBase/DataBaseService.cs"
echo "\tpublic class DataBaseService: DbContext \n\t{" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DataBase/DataBaseService.cs"
echo "\t\tpublic DataBaseService(DbContextOptions options): base(options) \n\t\t{}" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DataBase/DataBaseService.cs"
echo "\n\t}\n}" >> "src/Infraestructure/Persistence/$Company.$Application.Persistence/DataBase/DataBaseService.cs"
echo "Archivo de configuracion $Company.$Application.Persistence/DataBase/DataBaseService.cs generado \n"

echo "\n###########################################"
echo "TERMINO CREACION DE PROYECTO C#"
echo "###########################################"

echo "\n###########################################"
echo "Recuerde que este es un proyecto base, por lo que debe agregar las configuraciones necesarias para su proyecto, JMRM (z9manuel)"
echo "###########################################"
