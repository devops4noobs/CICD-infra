properties([
    parameters([
        choice(
            choices: ['dev', 'stage', 'production'], 
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
                sh 'terraform -chdir=infra init'
                }
            }
        }
        stage('Validate') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-central-1') {
                sh 'terraform -chdir=infra validate'
                }
            }
        }
        stage('Action') {
            steps {
                withAWS(credentials: 'aws_creds', region: 'eu-central-1') {
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform -chdir=infra plan -var-file='../vars/variables.tfvars'"
                        }   else if (params.Terraform_Action == 'apply') {
                            sh "terraform -chdir=infra apply -var-file='../vars/variables.tfvars' -auto-approve"
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh "terraform -chdir=infra destroy -var-file='../vars/variables.tfvars' -auto-approve"
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
            }
        }
    }
}