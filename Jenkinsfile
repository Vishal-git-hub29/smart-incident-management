pipeline {
    agent any

    environment {
        BACKEND_IMAGE = "vishal29docker/smartims-backend:v1"
        FRONTEND_IMAGE = "vishal29docker/smartims-frontend:v2"
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
                docker stop smartims-backend || true
                docker rm smartims-backend || true

                docker run -d \
                  --name smartims-backend \
                  -p 8080:8080 \
                  $BACKEND_IMAGE
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
