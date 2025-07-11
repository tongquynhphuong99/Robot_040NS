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
                    robot --outputdir results Bases/Testcase/login.robot
                '''
            }
        }
    }

    post {
        always {
            //archiveArtifacts artifacts: 'results/*'
            robot outputPath: 'results'
        }
    }
}
