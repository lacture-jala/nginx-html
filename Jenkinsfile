pipeline{
    agent any
     environment {
        AWS_ACCOUNT_ID = '156172784305'
        AWS_REGION = 'ap-south-1'
        ECR_REPO_NAME = 'acr-repo'
        IMAGE_TAG = 'latest'  // You can dynamically set the build version
        ECR_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"
        EMAIL ="shiva.u.awsdevops@gmail.com"
    }

    stages{
         stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
         stage('login'){
            steps{
                sh '''
                aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }
         stage('build'){
            steps{
                sh '''
                docker build -t ${ECR_REPO_NAME} .
                '''
            }
        }
         stage('Tagging the image'){
            steps{
                sh '''
                docker tag ${ECR_REPO_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                docker push 156172784305.dkr.ecr.ap-south-1.amazonaws.com/acr-repo:latest
                '''
            }
        }
        stage('push image to ecr'){
            steps{
                sh '''
                docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                '''
            }
        }

        

        post {
            success {
                mail to: "${EMAIL}",
                    subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) succeeded",
                    body: "Good news! The build succeeded."
            }
            failure {
                mail to: "${EMAIL}",
                    subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) failed",
                    body: "Unfortunately, the build failed. Please check the logs."
            }
        }
    }
}