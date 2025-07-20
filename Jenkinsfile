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
        
        stage('Process Results') {
            steps {
                robot outputPath: 'results'
                sh '''
                    tar czf results.tar.gz -C results .
                '''
            }
        }
    }
    
    post {
        always {
            script {
                def webhookUrl = 'http://backend:8000/api/reports/jenkins/webhook'
                def payload = [
                    name: env.JOB_NAME,
                    build: [
                        number: env.BUILD_NUMBER,
                        result: currentBuild.result,
                        status: 'FINISHED',
                        timestamp: currentBuild.startTimeInMillis,
                        duration: currentBuild.duration
                    ]
                ]
                
                httpRequest(
                    url: webhookUrl,
                    httpMode: 'POST',
                    contentType: 'APPLICATION_JSON',
                    requestBody: groovy.json.JsonOutput.toJson(payload),
                    validResponseCodes: '200,201,202'
                )
                
                echo "Webhook sent to backend for job: ${env.JOB_NAME} with result: ${currentBuild.result}"
            }
        }
    }
}
