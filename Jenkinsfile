pipeline {
    agent any 
            stages {
                stage('Clone Repo') {
                    steps {
                        checkout([$class: 'GitSCM',
                                  branches: [[name: '*/master']],
                                  doGenerateSubmoduleConfigurations: false,
                                  extensions: [],
                                  submoduleCfg: [],
                                  userRemoteConfigs: [[url: 'https://github.com/BenMaxGCU/coursework_2.git']]])
                    }
                }
                stage('Testing') {
                    environment {
                        scannerHome = tool 'SonarQube'
                    }
                    steps {
                        withSonarQubeEnv('SonarQube'){
                            sh "${scannerHome}/bin/sonar-scanner -D sonar.login=admin -D sonar.password=admin"
                        }
                        timeout(time: 10, unit: 'MINUTES'){
                            waitForQualityGate abortPipeline: true
                        }
                    }
                }
                stage('Push to DockerHub') {
                    steps {
                        script {
                            dockerImage = docker.build('benmaxgcu/coursework2' + ':v2')
                            docker.withRegistry('', 'benmaxgcu') {
                                dockerImage.push()
                            }
                        }
                    }
                }
            }
}
