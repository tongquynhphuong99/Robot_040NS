aborted {
    script {
        // ✅ Gửi webhook khi job bị hủy
        def webhookUrl = 'http://backend:8000/api/reports/jenkins/webhook'
        def payload = [
            name: env.JOB_NAME,
            build: [
                number: env.BUILD_NUMBER,
                result: currentBuild.result,  // Sẽ là "ABORTED"
                status: 'FINISHED',
                timestamp: currentBuild.startTimeInMillis,
                duration: currentBuild.duration
            ]
        ]
        
        // Gửi HTTP request đến webhook
        httpRequest(
            url: webhookUrl,
            httpMode: 'POST',
            contentType: 'APPLICATION_JSON',
            requestBody: groovy.json.JsonOutput.toJson(payload),
            validResponseCodes: '200,201,202'
        )
        
        echo "✅ Webhook sent to backend for aborted job: ${env.JOB_NAME}"
    }
}
