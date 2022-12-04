pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'github-token', variable: 'TOKEN')]) {
                        sh 'cd app && npm version patch'
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh 'echo ${TOKEN}'
                        sh 'git remote set-url origin https://vlad-charle:${TOKEN}@github.com:vlad-charle/jenkins-practice.git'
                        sh 'git add .'
                        sh 'git commit -m "Jenkins: Increment version - patch"'
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }
    }
}