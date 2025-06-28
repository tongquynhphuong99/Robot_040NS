pipeline {
    agent {
        docker {
            image 'python:3.10'       // Docker image có sẵn python + pip
            args '-u root'            // Để cài thêm gói mà không bị lỗi permission
        }
    }

    stages {
        stage('Install Robot Framework') {
            steps {
                sh '''
                    pip install --upgrade pip
                    pip install robotframework
                '''
            }
        }

        stage('Checkout Code') {
            steps {
                git(
                    credentialsId: 'github-token',    // Token GitHub bạn đã cấu hình
                    url: 'https://github.com/tongquynhphuong99/Robot_040NS.git',
                    branch: 'main'
                )
            }
        }

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
