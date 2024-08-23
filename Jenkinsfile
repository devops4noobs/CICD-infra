properties([
    parameters([
        string(
            defaultValue: 'dev',
            name: 'Environment'
        ),
        choice(
            choices: ['plan', 'apply', 'destroy'], 
            name: 'Terraform_Action'
        )])
])
pipeline {
    agent any
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'main', url: 'https://github.com/devops4noobs/CICD-part1.git'
            }
        }
        stage('Init') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-central-1') {
                sh 'terraform  init'
                }
            }
        }
        stage('Validate') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-central-1') {
                sh 'terraform validate'
                }
            }
        }
        stage('Action') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-central-1') {
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform plan -var-file=variables.tfvars"
                        }   else if (params.Terraform_Action == 'apply') {
                            sh "terraform apply -var-file=variables.tfvars -auto-approve"
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh "terraform destroy -var-file=variables.tfvars -auto-approve"
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
            }
        }
    }
}