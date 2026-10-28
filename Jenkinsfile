pipeline {
  agent any
  environment { IMAGE = 'ravindras1156/medicare-plus' }
  stages {
    stage('Build Image') {
      steps {
        sh 'docker build -t $IMAGE:$BUILD_NUMBER --build-arg APP_VERSION=v1.$BUILD_NUMBER --build-arg THEME=blue .'
      }
    }
    stage('Push Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
          sh 'docker push $IMAGE:$BUILD_NUMBER'
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl set image deployment/medicare-app medicare=$IMAGE:$BUILD_NUMBER'
        sh 'kubectl rollout status deployment/medicare-app --timeout=120s'
      }
    }
  }
}
