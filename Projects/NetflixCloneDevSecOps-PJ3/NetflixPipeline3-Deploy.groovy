pipeline {
    agent {
      label 'k8master'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amelkalidas/DevSecOps-Project.git'
            }
        }
        stage('KubeDeploy') {
            steps {
                sh 'kubectl apply -f Kubernetes/deployment.yml'
                sh 'kubectl apply -f Kubernetes/node-service.yaml'
                sh 'kubectl apply -f Kubernetes/service.yml'
                sh 'kubectl get svc'
            }
        }
    }
}
