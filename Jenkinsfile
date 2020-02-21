pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build'
                sh './'
                archiveArtifacts artifacts: 'target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("kolyaalen/train-task")
                }
            }
        }
    }
}
