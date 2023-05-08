pipeline {
    environment {
        IMAGEN = "adpalgar24/proyecto_integrado"
        LOGIN = 'USER_DOCKERHUB'
    agent any

    stages {
        stage("Testeos de Django") {
            agent {
                docker { image "python:3"
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/apalgar24/django_tutorial'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'python3 manage.py test'
                    }
                }

            }
        }

    stage("Build y push") {
            agent any
            stages {
                stage('CloneAnfitrion') {
                    steps {
                        git branch:'main',url:'https://github.com/apalgar24/jenkins_django.git'
                    }
                }
		stage ('Prebuild sin caché') {
                    steps {
                        sh 'docker build --no-cache -t $IMAGEN:latest .'
                        }
                    }
                stage('BuildImage') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('UploadImage') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }

    def deployToOpenShift() {
        stage('Deploy to OpenShift') {
            steps {
                // Incluir aquí los comandos necesarios para desplegar la aplicación en OpenShift
                sh 'oc login --token=sha256~v7ThmFIjYb8kafcJPRtU2bhoIuLG7C-wgnVXzglkSOI --server=https://api.sandbox-m3.1530.p1.openshiftapps.com:6443'
                sh 'oc new-app --docker-image=$IMAGEN:latest'
            }
        }
    }
}
