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
            // when {
            //     branch 'master'
            // }
            steps {
                echo "Build Docker Image step"
                script {
                    app = docker.build("kolyaalen/task")
                   // app.inside {
                   //     sh 'echo $(curl localhost:8080)'
                   // }
                }
            }
        }
        stage('Push Docker Image') {
            // when {
            //     branch 'master'
            // }
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
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker pull kolyaalen/task:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker stop kolyaalen/task\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker rm kolyaalen/task\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker run --restart always --name kolyaalen/task -p 8080:8080 -d kolyaalen/task:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}

