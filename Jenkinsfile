pipeline {
    agent {
        label "jenkins-agent"
    }

    tools {
        jdk 'Java17'
        maven 'Maven3'
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

<<<<<<< HEAD
        stage("Checkout Code") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/BURMETSKYI/K8s-project1.git'
            }
=======
    stages("Checkout from SCM"){
        stage {
            git branch: 'main', credentialsId: 'github', url: 'https://github.com/BURMETSKYI/'
        }

    }
    
    stages("Build Application"){
        stage {
            sh "mvn clean package"
        }

    }

    stages("Test Application"){
        stage {
            sh "mvn test"
>>>>>>> 4d99ea2 (added build and test stage)
        }
    }
}
