pipeline {
  agent any

  parameters {
    string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Branch to build')
    choice(name: 'RUN_TESTS', choices: ['YES', 'NO'], description: 'Run tests or not')
  }

  stages {
    stage('Clone Code') {
      steps {
        git branch: "${params.BRANCH_NAME}",
            url: 'https://github.com/nishantarorasfd006-devops/salesforce-devops.git'
      }
    }

    stage('Build') {
      steps {
        echo "Building ${params.BRANCH_NAME}"
      }
    }

    stage('Test') {
      when {
        expression {
          params.RUN_TESTS == 'YES'
        }
      }
      steps {
        echo "Running tests..."
      }
    }
  }
}
