pipeline {
    agent any
    
    tools {
      jdk 'jdk17'
      nodejs 'node16'
    }
    environment {
      SONAR_HOME = tool "netflix-sonar"
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amelkalidas/DevSecOps-Project.git'
            }
            
        }
        stage('SonarQubeAnalysis') {
            steps {
                withSonarQubeEnv('netflix-sonar') {
                    sh '''$SONAR_HOME/bin/sonar-scanner -Dsonar.projectKey=Netflix -Dsonar.projectName=Netflix '''
                }
            }
            
        }
        stage('QualityGate') {
            steps {
                waitForQualityGate abortPipeline: false, credentialsId: 'Netflix-sonar'
            }
            
        }
        stage('Dependency Installation') {
            steps {
                sh "npm install"
            }
            
        }
        stage('OWASP SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-CHECK'
                dependencyCheckPublisher pattern: '**dependency-check-report.xml'
            }
        }
    }
}
