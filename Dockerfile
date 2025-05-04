# Etapa do build com java 21 e instalação do Maven
FROM maven:3.9.4-amazoncorretto-21 AS build 
WORKDIR /app

# Etapa de configuração e proparação do projeto 
COPY /src /app/src
COPY /pom.xml /app
RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip

# Etapa de execução da aplicação
FROM eclipse-temurin:21-jre-alpine
EXPOSE 80
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]