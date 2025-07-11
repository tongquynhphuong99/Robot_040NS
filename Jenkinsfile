pipeline {
    agent {
        docker {
            image 'demopq/robot-python-sele-chor:phuongttq'
            args '-u root'
        }
    }
    parameters {
        
        string(name: 'TASK_ID', defaultValue: '', description: 'ID của task')
        string(name: 'ID_PJ', defaultValue: '', description: 'ID của Project')
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
            //archiveArtifacts artifacts: 'results/*'
            robot outputPath: 'results'
             sh '''
             # Nén toàn bộ thư mục kết quả (results) bao gồm report.html, log.html, output.xml, ...
            tar czf results.tar.gz -C results .
            # Gửi file nén về backend
            curl -X POST -F "id_task=$TASK_ID" -F "report=@results.tar.gz" http://192.168.1.31:8000/upload_report
            
               
        '''
        }
    }
}
