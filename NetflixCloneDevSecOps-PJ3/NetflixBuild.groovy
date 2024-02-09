pipeline {
    agent any
    
    environment {
        NETFLIX_API_KEY = credentials('NETFLIXAPI')
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amelkalidas/DevSecOps-Project.git'
            }
            
        }
        stage('Docker Build') {
            steps {
                sh "docker build --build-arg TMDB_V3_API_KEY=${NETFLIX_API_KEY} -t ameldocker98/netflixott ."
            }
        }
        stage('Trivy Scan Image') {
            steps {
                sh 'trivy image ameldocker98/netflixott:latest --output netflixscan.txt'
            }
        }
        
        stage('Docker Push Image ') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub-token', toolName: 'docker') {
                        sh "docker push ameldocker98/netflixott:latest" 
                    }
                }                 
            }
        }
    }
}
