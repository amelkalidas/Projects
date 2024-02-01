pipeline {
    agent {
  label 'prodnode'
    }
    stages {
        stage ('Github-DevelopBranch') {
            steps {
                git branch: 'master', url: 'https://github.com/amelkalidas/Cap-PJ1.git'
            }
        }
        stage ('Build and Test') {
            steps {
                sh '''sudo docker build . -t prodapplication
                sudo docker stop prodcontainer && sudo docker rm prodcontainer || true
                sudo docker run -itd --name prodcontainer -p 80:80 prodapplication'''
            }
        }
    }   
    
 
}