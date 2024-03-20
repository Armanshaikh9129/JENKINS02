
pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY = ''
        AWS_SECRET_ACCESS_KEY = ''
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Set Environment Variables') {
            steps {
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'test',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        // Credentials will be automatically injected into environment variables
                    }
                }
            }
        }
         stages {
        stage('Terraform Execution') {
            steps {
                script {
                    def userInput = input(
                        id: 'userInput', 
                        message: 'Select Terraform action:', 
                        parameters: [
                            choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose Terraform action')
                        ]
                    )
                    
                    // Based on user input, execute the corresponding Terraform command
                    if (userInput.ACTION == 'Apply') {
                        sh 'terraform apply'
                    } else if (userInput.ACTION == 'Destroy') {
                        sh 'terraform destroy'
                    } else {
                        error 'Invalid choice. Please select either Apply or Destroy.'
                    }
                }
            }
        }
    }
}

    post {
        always {
            echo 'Cleaning up...'
            deleteDir()
        }
    }
}
