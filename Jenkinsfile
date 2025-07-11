pipeline {
    agent {
        docker {
            image 'demopq/robot-python-sele-chor:phuongttq'
            args '-u root'
        }
    }
    parameters {
        string(name: 'REPO_URL', defaultValue: '', description: 'Link repo')
        string(name: 'TASK_ID', defaultValue: '', description: 'ID của task')
        string(name: 'TESTSUITE', defaultValue: '', description: 'Tên testsuite')
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
