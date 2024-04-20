pipeline {
    agent {
  label 'Testnode'
    }
    stages {
        stage ('Github-Masterbranch') {
            steps {
                git branch: 'master', url: 'https://github.com/amelkalidas/Cap-PJ1.git'
            }
        }
        stage ('Build and Test') {
            steps {
                sh '''sudo docker build . -t prodapplicationtesting
                sudo docker stop prodcontainer01 && sudo docker rm prodcontainer01 || true
                sudo docker run -itd --name prodcontainer01 -p 81:80 prodapplicationtesting'''
            }
        }
    }   
    
 
}