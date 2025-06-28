pipeline {
    agent {
        docker {
            image 'python:3.10'
            args '-u root' // Cho phép cài gói hệ thống bằng apt
        }
    }

    environment {
        ROBOT_CACHE_DIR = '/tmp/robot_cache_${BUILD_NUMBER}' // Tránh xung đột profile Chrome
    }

    stages {
        stage('Prepare Environment') {
            steps {
                sh '''
                    apt-get update
                    apt-get install -y curl unzip wget gnupg software-properties-common

                    # Cài Chrome
                    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
                    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
                    apt-get update
                    apt-get install -y google-chrome-stable

                    # Tải ChromeDriver tương thích
                    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d. -f1)
                    DRIVER_VERSION=$(curl -sSL https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
                    curl -sSL https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip -o chromedriver.zip
                    unzip chromedriver.zip
                    mv chromedriver /usr/local/bin/
                    chmod +x /usr/local/bin/chromedriver

                    # Cài Python packages
                    pip install --upgrade pip
                    pip install robotframework selenium robotframework-seleniumlibrary
                '''
            }
        }

        stage('Checkout Source') {
            steps {
                git(
                    credentialsId: 'github-token',
                    url: 'https://github.com/tongquynhphuong99/Robot_040NS.git',
                    branch: 'main'
                )
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh '''
                    mkdir -p results
                    robot --outputdir results \
                          --variable USER_DATA_DIR:${ROBOT_CACHE_DIR} \
                          Bases/Testcase/
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
