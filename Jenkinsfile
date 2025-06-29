pipeline {
    agent {
        docker {
            image 'demopq/robot-python-sele-chor:phuongttq'
            args '-u root'
        }
    }

    stages {
        stage('Run Robot Tests') {
            steps {
                sh 'robot Bases/Testcase/login.robot'
            }
        }
    }

    post {
        always {
            // archiveArtifacts artifacts: 'results/*'
            robot outputPath: 'results'
        }
    }
}

