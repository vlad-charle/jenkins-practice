pipeline {
    agent any

    stages {
        // stage('Increment version') {
        //     steps {
        //         script {
        //             withCredentials([
        //                 string(credentialsId:'github-token', variable: 'TOKEN'),
        //                 string(credentialsId:'github-login', variable: 'LOGIN')
        //                 ]) {
        //                 sh 'cd app && npm version patch'
        //                 sh 'git remote set-url origin https://${LOGIN}:${TOKEN}@github.com/vlad-charle/jenkins-practice.git'
        //                 sh 'git add .'
        //                 sh 'git commit -m "Jenkins: Increment version - patch"'
        //                 sh 'git push origin HEAD:main'
        //             }
        //         }
        //     }
        // }

        // stage('Run tests') {
        //     steps {
        //         sh 'cd app && npm install && npm run test'
        //     }

        //     post {
        //         failure {
        //             sh 'exit 1'
        //         }
        //     }
        // }

        stage('Build image') {
            steps {
                script {
                    def matcher = readJSON file: 'app/package.json'
                    def appVersion = matcher.version
                    env.IMAGE_NAME = "$appVersion-$BUILD_NUMBER"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t vladsanyuk/app:$IMAGE_NAME ."
                        sh "echo $PASS | docker login -u $USER -password-stdin"
                        sh "docker push vladsanyuk/app:$IMAGE_NAME"
                    }
                }
            }
        }
    }
}