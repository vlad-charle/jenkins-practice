pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                sh 'cd app && npm version patch'
                sh 'git config --global user.email "jenkins@example.com"'
                sh 'git config --global user.name "jenkins"'
                sh 'git add .'
                sh 'git commit -m "Jenkins: Increment version - patch"'
                sh 'git push'
            }
        }
    }
}