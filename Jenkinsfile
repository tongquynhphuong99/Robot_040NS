pipeline {
    agent {
        docker {
            image 'python:3.10'
            args '-u root'  // tránh lỗi permission khi apt install/pip install
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git(
                    credentialsId: 'github-token',
                    url: 'https://github.com/tongquynhphuong99/Robot_040NS.git',
                    branch: 'main'
                )
            }
        }

        stage('Install Chrome & Driver') {
            steps {
                sh '''
                    apt-get update
                    apt-get install -y wget curl unzip gnupg \
                        fonts-liberation libnss3 libxss1 libappindicator1 libasound2 libgbm-dev libgtk-3-0

                    # Cài Google Chrome
                    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                    apt install -y ./google-chrome-stable_current_amd64.deb || apt --fix-broken install -y
                    rm google-chrome-stable_current_amd64.deb

                    # Cài Chromedriver (tự động theo version của Chrome)
                    CHROME_VERSION=$(google-chrome --version | grep -oP '\\d+\\.\\d+\\.\\d+')
                    DRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION%.*})
                    wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip
                    unzip /tmp/chromedriver.zip -d /usr/local/bin/
                    chmod +x /usr/local/bin/chromedriver
                '''
            }
        }

        stage('Install Python dependencies') {
            steps {
                sh '''
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

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
