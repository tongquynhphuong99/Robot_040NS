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
             sh '''
            if [ -f results/report.html ]; then
                curl -X POST -F "id_task=$TASK_ID" -F "report=@results/report.html" http://192.168.1.31:8000/upload_report
            fi
            
            python3 -c "import xml.etree.ElementTree as ET; tree = ET.parse('results/output.xml'); root = tree.getroot(); stats = root.find('statistics').find('total').findall('stat'); [print(f'{s.attrib[\\\"name\\\"]}: Pass={s.attrib[\\\"pass\\\"]}, Fail={s.attrib[\\\"fail\\\"]}') for s in stats]" > results/summary.txt
               
        '''
        }
    }
}
