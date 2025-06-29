pipeline {
    agent {
        docker {
            // image 'python:3.10'
            image 'demopq/robot-python-sele-chor:phuongttq'
            args '-u root'  // tránh lỗi permission khi apt install/pip install
        }
    }

    // stages {
    //     stage('Checkout') {
    //         steps {
    //             git(
    //                 credentialsId: 'github-token',
    //                 url: 'https://github.com/tongquynhphuong99/Robot_040NS.git',
    //                 branch: 'main'
    //             )
    //         }
    //     }

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
