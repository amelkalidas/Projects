pipeline {
    agent {
  label 'Testnode'
    }
    stages {
        stage ('Github-DevelopBranch') {
            steps {
                git branch: 'develop', url: 'https://github.com/amelkalidas/Cap-PJ1.git'
            }
        }
        stage ('Build and Test') {
            steps {
                sh '''sudo docker build . -t devappliccation
                sudo docker stop devcontainer01 ; sudo docker rm devcontainer01
                sudo docker run -itd --name devcontainer01 -p 82:80 devappliccation'''
            }
        }
    }   
    
 
}