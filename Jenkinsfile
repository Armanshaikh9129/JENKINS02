pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = ''
        AWS_SECRET_ACCESS_KEY = ''
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Set Environment Variables') {
            steps {
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_cred',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        // Credentials will be automatically injected into environment variables
                    }
                }
            }
        }
        
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
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    } else if (userInput.ACTION == 'Destroy') {
                        sh 'terraform destroy -auto-approve'
                    } else {
                        error 'Invalid choice. Please select either Apply or Destroy.'
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
