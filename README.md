# flask-ml-azure-serverless

## adding small change in readme to test commit

Deploy Flask Machine Learning Application on Azure App Services



## To run it locally follow these steps

1.  Create virtual environment and source

```bash
python3 -m venv ~/.flask-ml-azure
source ~/.flask-ml-azure/bin/activate
```

2.  Run `make install`

3.  Run `python app.py`

4.  In a separate shell run: `./make_prediction.sh`

## To run it in Azure Pipelines

1.  Refer to [Azure Official Documentation guide here throughout](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops)

2. Launch Azure Shell  

3.  Create Github Repo with Azure Pipelines Enabled (Could be a fork of this repo)

4. Clone the repo into Azure Cloud Shell

5.  Create virtual environment and source

```bash
python3 -m venv ~/.flask-ml-azure
source ~/.flask-ml-azure/bin/activate
```

2.  Run `make install`

3.  Create an app service and initially deploy your app in Cloud Shell

`az webapp up -n <your-appservice>`

![3-flask-ml-service](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/main/Screen%20Shot%202021-11-03%20at%201.55.43%20PM.png)

4. Verify deployed application works by browsing to deployed url: `https://<your-appservice>.azurewebsites.net/`

You will see this output:

![4-deployed-app](https://user-images.githubusercontent.com/58792/89557343-a8088c00-d7e0-11ea-891c-4d88333b8097.png)

5.  Verify Machine Learning predictions work

Change the line in `make_predict_azure_app.sh` to match the deployed prediction
`-X POST https://<yourappname>.azurewebsites.net:$PORT/predict `

![5-successful-prediction](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/main/Screen%20Shot%202021-11-03%20at%202.01.43%20PM.png)

6. [Create an Azure DevOps project and connect to Azure, (as official documentation describes)](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops)


7.  Connect to Azure Resource Manager


8.  Configure connection to previously deployed resource group

9.  Create new Python Pipeline with Github Integration
# Python to Linux Web App on Azure
# Build your Python project and deploy it to Azure as a Linux Web App.
# Change python version to one thats appropriate for your application.
# https://docs.microsoft.com/azure/devops/pipelines/languages/python

trigger:
- main

variables:
  # Azure Resource Manager connection created during pipeline creation
  azureServiceConnectionId: 'ServiceConnection'

  # Web app name
  webAppName: 'flask-ml-service-pkesarwani'

  # Agent VM image name
  vmImageName: 'ubuntu-latest'

  # Environment name
  environmentName: 'flask-ml-service-pkesarwani'

  # Project root folder. Point to the folder containing manage.py file.
  projectRoot: $(System.DefaultWorkingDirectory)

  # Python version: 3.7
  pythonVersion: '3.7'

stages:
- stage: Build
  displayName: Build stage
  jobs:
  - job: BuildJob
    pool:
      vmImage: $(vmImageName)
    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '$(pythonVersion)'
      displayName: 'Use Python $(pythonVersion)'

    - script: |
        python -m venv antenv
        source antenv/bin/activate
        python -m pip install --upgrade pip
        pip install setup
        pip install -r requirements.txt
      workingDirectory: $(projectRoot)
      displayName: "Install requirements"

    - task: ArchiveFiles@2
      displayName: 'Archive files'
      inputs:
        rootFolderOrFile: '$(projectRoot)'
        includeRootFolder: false
        archiveType: zip
        archiveFile: $(Build.ArtifactStagingDirectory)/$(Build.BuildId).zip
        replaceExistingArchive: true

    - upload: $(Build.ArtifactStagingDirectory)/$(Build.BuildId).zip
      displayName: 'Upload package'
      artifact: drop

- stage: Deploy
  displayName: 'Deploy Web App'
  dependsOn: Build
  condition: succeeded()
  jobs:
  - deployment: DeploymentJob
    pool:
      vmImage: $(vmImageName)
    environment: $(environmentName)
    strategy:
      runOnce:
        deploy:
          steps:

          - task: UsePythonVersion@0
            inputs:
              versionSpec: '$(pythonVersion)'
            displayName: 'Use Python version'

          - task: AzureWebApp@1
            displayName: 'Deploy Azure Web App : flask-ml-service-pkesarwani'
            inputs:
              azureSubscription: $(azureServiceConnectionId)
              appName: $(webAppName)
              package: $(Pipeline.Workspace)/drop/$(Build.BuildId).zip
              
10.  Verify Continuous Delivery of Azure Pipelines by changing `app.py`


11.  Add a lint step (this gates your code against syntax failure)

```
    - script: |
        python -m venv antenv
        source antenv/bin/activate
        make install
        make lint
      workingDirectory: $(projectRoot)
      displayName: 'Run lint tests'
```

You can watch this [YouTube Walkthrough of this process](https://youtu.be/Vpb7TqvzxnE)



