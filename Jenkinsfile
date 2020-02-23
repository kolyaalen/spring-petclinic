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
                    app.inside {
                        sh 'echo $(curl localhost:8080)'
                    }
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
    }
}
