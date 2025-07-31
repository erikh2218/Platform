pipeline {
  agent {
    node {
      label 'platform'
    }

  }
  stages {
    stage('error') {
      steps {
        sh 'echo $APP'
      }
    }

  }
  environment {
    APP = 'platform'
  }
}