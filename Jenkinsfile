pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build'
                sh './mvnw package'
                archiveArtifacts artifacts: 'target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Build Docker Image step"
                script {
                    app = docker.build("kolyaalen/task")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Push Docker Image step"
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        echo "${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('DeployToProduction') {
            steps {
                input 'Deploy to Production?'
                milestone(1)
                sshagent(['aws_prod']) {
                    script {
                        sh ssh  StrictHostKeyChecking=no \"docker pull kolyaalen/task:${env.BUILD_NUMBER}\""
                        try {
                            sh ssh  StrictHostKeyChecking=no \"docker stop kolyaalen_task\""
                            sh ssh  StrictHostKeyChecking=no  \"docker rm kolyaalen_task\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh ssh -o StrictHostKeyChecking=no \"docker run --restart always --name kolyaalen_task -p 8080:8080 -d kolyaalen/task:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}

