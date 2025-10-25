# 🌾 AgroRent - Configuración de Entornos

# Configuración para desarrollo local
# Usar: mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Configuración para producción con Docker
# Usar: docker-compose up --build -d

# Configuración para pruebas
# Usar: mvn test

# Variables de entorno recomendadas:

# Para desarrollo local:
# export SPRING_PROFILES_ACTIVE=dev
# export SERVER_PORT=8080
# export SERVER_SERVLET_CONTEXT_PATH=/recetas

# Para producción:
# export SPRING_PROFILES_ACTIVE=prod
# export SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/agrorent
# export SPRING_DATASOURCE_USERNAME=agrouser
# export SPRING_DATASOURCE_PASSWORD=agropass

# Para Docker:
# export SPRING_PROFILES_ACTIVE=prod
# export SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/agrorent
# export SPRING_DATASOURCE_USERNAME=agrouser
# export SPRING_DATASOURCE_PASSWORD=agropass
# export SERVER_SERVLET_CONTEXT_PATH=/recetas
