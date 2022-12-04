pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId:'github-token', variable: 'TOKEN'),
                        string(credentialsId:'github-login', variable: 'LOGIN')
                        ]) {
                        sh 'cd app && npm version patch'
                        sh 'git remote set-url origin https://${LOGIN}:${TOKEN}@github.com/vlad-charle/jenkins-practice.git'
                        sh 'git add .'
                        sh 'git commit -m "Jenkins: Increment version - patch"'
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }

        stage('Run tests') {
            steps {
                sh 'echo "${PWD}"'
                sh 'echo "$(ls -l)"'
            }
        }
    }
}