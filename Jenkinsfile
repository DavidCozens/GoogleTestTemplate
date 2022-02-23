pipeline {
  agent {
    docker {
      image 'davidcozens/googletest:4'
      registryCredentialsId 'dockerhub'
    }
  }
  stages {
    stage('build') {
      steps{
        sh 'make -j run'
      }
    }
  }
  post {
    always {
      xunit thresholds: [failed(failureThreshold: '0')], tools: [GoogleTest(excludesPattern: '', pattern: '*.out.xml', stopProcessingIfError: true)]
    }
    cleanup {
      cleanWs()
    }
  }
}
