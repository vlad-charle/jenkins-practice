pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'github', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh 'cd app && npm version patch'
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh 'git remote set-url origin https://${USER}:${PASS}@github.com:vlad-charle/jenkins-practice.git'
                        sh 'git add .'
                        sh 'git commit -m "Jenkins: Increment version - patch"'
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }
    }
}