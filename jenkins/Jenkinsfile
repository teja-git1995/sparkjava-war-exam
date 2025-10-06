pipeline {
	agent any 
	environment {
		IMAGE = 'teja/firstimage:1.0'
		GITURL = 'https://github.com/teja-git1995/sparkjava-war-exam.git'
	}
	
	tools {
		maven mymvn
	}

	stages{
		stage('checkout') {
			steps {
			  git branch: 'main', url: "${GITURL}"
			}
		}
		
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
