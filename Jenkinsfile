pipeline {
    agent any 
            stage {
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
                        scannerHome = tool 'SonarQubeScanner'
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
                            def app = docker.build("benmaxgcu/coursework_2")
                            docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_credentials') {
                                app.push("${env.BUILD_NUMBER}")
                                app.push("latest")
                            }
                        }
                    }
                }
            }
}
