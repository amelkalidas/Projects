pipeline {
    agent none
    environment { 
        DOCKER_CREDENTIAL = credentials('dockerhub') 
        VERSION = "1.0.${env.BUILD_NUMBER}"
        DOCKER_REPO = 'ameldocker98'
        IMAGE_NAME = 'vault:apacimage'
    }

    stages {
        stage('Gitpull') {
            agent {
                label 'K8Master'
            }
            steps {
                git branch: 'main', url: 'https://github.com/amelkalidas/CICD2.git'
            }
        }
        stage('Builddockerfile') {
            agent {
                label 'K8Master'
            }
            steps {
                script {
                    def imageWithTag = "${DOCKER_REPO}/${IMAGE_NAME}${VERSION}"
                    sh "sudo docker build --file Dockerfile -t ${imageWithTag} . "
                    sh "sudo echo $DOCKER_CREDENTIAL_PSW | sudo docker login -u $DOCKER_CREDENTIAL_USR --password-stdin"
                
                    sh "sudo docker push ${imageWithTag} "
                }
            }
        }
        stage('Kubedeployment') {
            agent {
                label 'K8Master'
            }
            steps {
                sh 'kubectl delete deploy apacheimage-deployment '
                sh 'kubectl apply -f deployment.yaml '
                sh 'kubectl apply -f services.yaml'
            }
        }
    }
}
