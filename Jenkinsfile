node {
    docker.image('demopq/robot-python-sele-chor:phuongttq').inside('-u root') {
        stage('Run Robot Tests') {
            sh '''
                mkdir -p results
                robot --outputdir results Bases/Testcase/login.robot
            '''
        }
        
        stage('Send Webhook') {
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
        
        stage('Process Results') {
            robot outputPath: 'results'
            sh '''
                tar czf results.tar.gz -C results .
            '''
        }
    }
}
