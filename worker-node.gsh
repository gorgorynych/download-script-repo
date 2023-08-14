import jenkins.model.Jenkins

def repo_script = "https://raw.githubusercontent.com/gorgorynych/travelline-sre-challenge/main/script.sh"

/*
def inst = Jenkins.getInstance()
def emailExt = inst.getDescriptor("hudson.plugins.emailext.ExtendedEmailPublisher")

emailExt.setSmtpAuth("igor.dmitrievykh@yandex.ru",
                     "vaswbbqxtwgxtlvt")
emailExt.setDefaultReplyTo("igor.dmitrievykh@yandex.ru")
emailExt.setSmtpServer("smtp.yandex.com")
emailExt.setUseSsl(true)
emailExt.setSmtpPort("465")
emailExt.setCharset("utf-8")
emailExt.setDefaultRecipients(params.Recipient)

emailExt.save()
*/

pipeline{
  agent any
  environment{
    REQUEST_SCRIPT="/tmp/script.sh"
    REQUEST_RESULT="Success"
  }

  stages{
    stage("1. stage"){
      steps{
        sh "curl ${repo_script} > ${REQUEST_SCRIPT}"
      }
    }
    stage('2. stage'){
      steps{
        script{
          sh "cat -e ${REQUEST_SCRIPT} > script.sh"
          REQUEST_RESULT = sh (
              script: "sh ${REQUEST_SCRIPT} ${params.URL}",
              returnStdout: true
            ).trim()
          echo "Results: ${REQUEST_RESULT}"
        }
      }
    }
    // Doesn't actually send email. TODO
    stage('3. stage'){
      steps{
        emailext(to: params.Email, subject: "HTTP request - ${REQUEST_RESULT}", body: "${REQUEST_RESULT}")
      }
    }
  }
}
