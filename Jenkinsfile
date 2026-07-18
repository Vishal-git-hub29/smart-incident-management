pipeline {
    agent any

    environment {
        BACKEND_IMAGE = "vishal29docker/smartims-backend:v1"
        FRONTEND_IMAGE = "vishal29docker/smartims-frontend:v3"
    }

    stages {

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'chmod +x mvnw || true'
                    sh './mvnw clean package -DskipTests || mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                dir('backend') {
                    sh 'docker build -t $BACKEND_IMAGE .'
                }

                dir('frontend') {
                    sh 'docker build -t $FRONTEND_IMAGE .'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker pull $BACKEND_IMAGE
                docker pull $FRONTEND_IMAGE

                docker stop smartims-backend || true
                docker rm smartims-backend || true

                docker run -d \
                  --name smartims-backend \
                  --network smartims-compose_smartims-network \
                  -p 8080:8080 \
                  -e DB_URL=jdbc:postgresql://postgres-container:5432/smartims \
                  -e DB_USERNAME=postgres \
                  -e DB_PASSWORD=postgres \
                  -e JWT_SECRET=ThisIsASecretKeyForJwtSigningMustBeAtLeast32Chars \
                  $BACKEND_IMAGE

                docker stop smartims-frontend || true
                docker rm smartims-frontend || true

                docker run -d \
                  --name smartims-frontend \
                  -p 80:80 \
                  $FRONTEND_IMAGE
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline Completed Successfully"
        }

        failure {
            echo "Pipeline Failed"
        }
    }
}
