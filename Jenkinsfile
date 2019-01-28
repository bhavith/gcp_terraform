pipeline {
    agent {
        label "docker-builder"
    }

node("docker-builder") {}

#Choose from a list of folders in a path
def configDirs = sh(script: "ls -d ${CONFIG_PATH}", returnStdout: true)
def chooseProject(configDirs){
    PROJECT_DIR = input( id: 'userInput', message: 'Choose an image to build',
        parameters: [ [
            $class: 'ChoiceParameterDefinition',
            choices: configDirs,
            description: 'Properties',
            name: 'Available projects:'] ])
    PROJECT_DIR
}


def call (){
    def isStartedByUser = currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null
    return isStartedByUser ? "MANUAL" : "AUTOMATIC"
}


#!/usr/bin/env groovy

def call () {
    Set PATHS = []
    currentBuild.changeSets.each { cs ->
        cs.getItems().each { item ->
            item.getAffectedPaths().each { PATHS << it }
        }
    }
    PATHS
}


#!/usr/bin/env groovy

def call () {
    Set paths = []
    currentBuild.changeSets.each { cs ->
        cs.getItems().each { item ->
            item.getAffectedPaths().each {
                if (it.contains("/") && !it.startsWith("vars/"))
                    paths << it.substring(0, it.lastIndexOf("/")) }
        }
    }
  	def changedPaths = String.join(",", paths)
    println("Changed paths:" + changedPaths)
    return changedPaths
}



#!/usr/bin/env groovy

def call (String outputmessage = "") {

      manager.getBuild().setDescription("$outputmessage")

}

