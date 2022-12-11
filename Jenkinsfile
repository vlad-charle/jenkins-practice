@Library('jenkins-shared-library')_

pipeline {
    agent any

    stages {
        stage('Increment version') {
            when {
                expression {
                    BRANCH_NAME == 'main'
                }
            }
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
            when {
                expression {
                    BRANCH_NAME == 'main'
                }
            }
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
            when {
                expression {
                    BRANCH_NAME == 'main'
                }
            }
            steps {
                script {
                    registryLogin()
                    pushImage "$IMAGE_NAME"
                }
            }
        }

        stage('Deploy to EC2') {
            when {
                expression {
                    $BRANCH_NAME == 'main'
                }
            }
            steps {
                script {
                    def ec2 = "ec2-user@18.232.76.231"
                    def executeScript = "bash ./server-script.sh ${IMAGE_NAME}"
                    sshagent(['ec2-server-key']) {
                        sh "scp server-script.sh ${ec2}:/home/ec2-user"
                        sh "scp docker-compose.yaml ${ec2}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2} ${executeScript}"
                    }
                }
            }
        }

        stage('Commit to Git') {
            when {
                expression {
                    BRANCH_NAME == 'main'
                }
            }
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