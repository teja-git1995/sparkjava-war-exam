pipeline {
	agent any 
	environment {
		IMAGE = 'teja072/teja:latest'
		CONTAIN = 'helloworld'
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
		stage('Docker deploy') {
			steps {
				sh 'docker run -itd -p 8081:8080 --name ${CONTAIN} ${IMAGE}'
			}
		}
		}
	}
