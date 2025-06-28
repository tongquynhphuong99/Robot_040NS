pipeline {
    agent {
        docker {
            image 'python:3.10'  // Có sẵn pip
            image 'ppodgorsek/robot-framework:latest'
            args '-u root'       // Tránh lỗi khi pip install
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git(
                    credentialsId: 'github-token', // Token GitHub
                    url: 'https://github.com/tongquynhphuong99/Robot_040NS.git',
                    branch: 'main'
                )
            }
        }

        // stage('Install dependencies') {
        //     steps {
        //         sh 'pip install -r requirements.txt'
        //     }
        // }

        stage('Run Robot Tests') {
            steps {
                sh '''
                    mkdir -p results
                    robot --outputdir results Bases/Testcase/
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/*'
        }
    }
}
