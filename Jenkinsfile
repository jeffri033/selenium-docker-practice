
pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t selenium-docker-jenkins .'
            }
        }
        stage('Run Tests in Docker') {
            steps {
                sh 'docker run --rm selenium-docker-jenkins'
            }
        }
    }
}
