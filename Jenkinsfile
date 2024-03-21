pipeline {
    agent any

    environment {
        // These environment variables are placeholders. Actual values are injected by `withCredentials`.
        AWS_ACCESS_KEY_ID = ''
        AWS_SECRET_ACCESS_KEY = ''
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Set Environment Variables') {
            steps {
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'AWS_CRED',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        // No additional commands needed here; credentials are set up for the following stages.
                    }
                }
            }
        }

        stage('Terraform Initialization and Execution') {
            steps {
                script {
                    def userInput = input(
                        id: 'userInput', 
                        message: 'Select Terraform action:', 
                        parameters: [
                            choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose Terraform action')
                        ]
                    )

                    // Initialize Terraform once at the beginning of the execution stage.
                    sh 'terraform init'

                    // Execute Terraform apply or destroy based on user input.
                    if (userInput == 'Apply') {
                        sh 'terraform apply -auto-approve'
                    } else if (userInput == 'Destroy') {
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
            deleteDir() // This cleans up the workspace after the job is done.
        }
    }
}
