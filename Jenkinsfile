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
                    robot --outputdir results Bases/Testcase/
                '''
            }
        }
    }

    post {
        always {
            robot outputPath: 'results'
            sh '''
                # Nén toàn bộ thư mục kết quả (results) bao gồm report.html, log.html, output.xml, ...
                tar czf results.tar.gz -C results .
                # Gửi file nén về backend (có thể comment lại nếu chưa cần)
                # curl -X POST -F "report=@results.tar.gz" http://192.168.240.56:8000/upload_report
            '''
        }
    }
}
