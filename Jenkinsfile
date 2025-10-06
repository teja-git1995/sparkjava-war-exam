pipeline {
	agent any 
	environment {
		IMAGE = 'teja072/teja:latest'
		DEV = 'dev_helloworld'
		PROD = 'prod_hello'
	}
	
	tools {
		maven 'mymvn'
	}

	stages{
		stage('maven build') {
			steps { 
			    sh ' mvn clean package -DskipTests'
			}
		}
		
		stage('Docker build') {
			steps {
			    sh 'docker build -t ${IMAGE} .'
			}
		}
		
		stage('Docker push') {
			steps {
                	   withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE}
                        docker logout
                    """
                          }
			
			}
		}
		
		stage('Docker Dev deploy') {
			steps {
				sh 'docker run -itd -p 8081:8080 --name ${DEV} ${IMAGE}'
			}
		}
		stage('Approval Deploy to Production') {
            steps {
                script {
                    input message: 'Do you want to deploy to production?', ok: 'Deploy'
                }
                echo 'Deployment started...'
            }
        }
		stage('Docker Prod deploy') {
			steps {
				sh 'docker run -itd -p 8082:8080 --name ${PROD} ${IMAGE}'
			}
		}
		}
	}
