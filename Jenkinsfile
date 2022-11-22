pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                echo "hello world"
                sh 'ls -l'
                sh 'cd app'
                sh 'pwd'
                sh 'npm version patch'
                // sh 'cd .. && git add .'
                // git commit -m "Jenkins: Increment version - patch"
                // git push
            }
        }
    }
}