@Library('jenkins-shared-library')_

pipeline {
    agent any

    stages {
        stage('Increment version') {
            steps {
                    sh 'cd app && npm version patch'
            }
        }

        stage('Run tests') {
            steps {
                sh 'cd app && npm install && npm run test'
            }

            post {
                failure {
                    sh 'exit 1'
                }
            }
        }

        stage('Build image') {
            steps {
                script {
                    def matcher = readJSON file: 'app/package.json'
                    def appVersion = matcher.version
                    env.IMAGE_NAME = "$appVersion-$BUILD_NUMBER"
                    buildImage "$IMAGE_NAME"
                }
            }
        }

        stage('Push to Docker repository') {
            steps {
                script {
                    registryLogin()
                    pushImage "$IMAGE_NAME"
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    def dockerCompose = "docker-compose -f docker-compose.yaml -d"
                    sshagent(['ec2-server-key']) {
                        sh "scp docker-compose.yaml ec2-user@18.232.76.231:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@18.232.76.231 ${dockerCompose}"
                    }
                }
            }
        }

        stage('Commit to Git') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId:'github-token', variable: 'TOKEN'),
                        string(credentialsId:'github-login', variable: 'LOGIN')
                        ]) {
                        sh 'git remote set-url origin https://${LOGIN}:${TOKEN}@github.com/vlad-charle/jenkins-practice.git'
                        sh 'git add app/package.json'
                        sh 'git commit -m "Jenkins: Increment version - patch"'
                        sh 'git push origin HEAD:main'
                    }
                }
            }
        }
    }
}