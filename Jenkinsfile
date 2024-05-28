pipeline {
    agent any 
    stages {
        stage('Pull from git'){
        steps {
            sh 'rm -rf inadev'
            sh 'git clone https://github.com/roceb/inadev'
            sh 'cd inadev/backend'
        }
        }
        stage('Test') { 
            steps {
                sh 'docker build --target=test .'
            }
        }
        stage('Build') { 
            steps {
                sh 'docker build --target=production -t 090204989564.dkr.ecr.us-east-2.amazonaws.com/indev:latest --platform linux/amd64 .'
            }
        }
        stage('Deploy'){
            steps {
                sh 'docker push 090204989564.dkr.ecr.us-east-2.amazonaws.com/indev:latest'
            }
        }
}}