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
                sh '''
                    mkdir -p results
                    robot --outputdir results Bases/Testcase/login.robot
                '''
            }
        }
    }

    post {
        always {
            script {
                // ✅ Phân tích kết quả Robot Framework
                robot outputPath: 'results'

                // ✅ Nén và chuẩn bị gửi report
                sh '''
                    tar czf results.tar.gz -C results .

                    # curl -X POST -F "report=@results.tar.gz" http://192.168.240.56:8000/upload_report
                '''
            }
        }
    }
}
