# Use a imagem oficial do Maven 3.6.3 com JDK 11 como base
FROM maven:3.6.3-openjdk-17 as build

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o pom.xml e faça o download das dependências
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copie o restante do código e construa o projeto
COPY src ./src
RUN mvn package -DskipTests

# Use a imagem oficial do OpenJDK 11 para rodar a aplicação
FROM openjdk:17-jdk-slim

# Copie o jar do estágio de construção
COPY --from=build /app/target/*.jar app.jar

# Exponha a porta 80
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["java","-jar","/app.jar"]