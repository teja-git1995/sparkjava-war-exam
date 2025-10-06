pipeline {
	agent any 
	environment {
		IMAGE = 'teja/firstimage:1.0'
	}
	
	tools {
		maven mymvn
	}

	stages{
		stage('maven build') {
			steps { 
			    sh ' mvn clean package -DskipTests'
			}
		}
		
		stage('Docker build') {
			steps {
			    sh ' docker bulid -t ${IMAGE} .'
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
	}
}
