# flask-ml-azure-serverless

## adding small change in readme to test commit

![Project Management Tempalate](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/eddd1d5fb6cf16e85de1f2c71dd546b7fcbe1b2c/Screen%20Shot%202021-11-04%20at%204.52.25%20PM.png)

![trello link](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/main/Screen%20Shot%202021-11-04%20at%204.56.21%20PM.png)

https://trello.com/b/WEuIlu5q/project-management

GitHub Link to demonstrate cloning the project from GitHub repo and then pushing any small change via azure cloud shell to trigger the GitHub Actions build and Azure Devops Pipeline. [Git repo](https://github.com/pikukesar/azurepython2)


## Deploy Flask Machine Learning Application on Azure App Services that gives Boston Housing prediction

![continuous-delivery](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/038ee232df94a4ba257a695f28417e3c52b7cc84/Screen%20Shot%202021-11-04%20at%204.37.21%20PM.png)


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

![4-deployed-app](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/main/Screen%20Shot%202021-11-03%20at%202.01.43%20PM.png)

5.  Verify Machine Learning predictions work

Change the line in `make_predict_azure_app.sh` to match the deployed prediction
`-X POST https://<yourappname>.azurewebsites.net:$PORT/predict `

![5-successful-prediction](https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/beda2e8b8424e2a3b0e084479b26f8403e671378/Screen%20Shot%202021-11-02%20at%2012.19.15%20PM.png)


6. [Create an Azure DevOps project and connect to Azure, (as official documentation describes)](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops)


7.  Connect to Azure Resource Manager


8.  Configure connection to previously deployed resource group

9.  Create new Python Pipeline with Github Integration

Python to Linux Web App on Azure
Build your Python project and deploy it to Azure as a Linux Web App.
Change python version to one thats appropriate for your application.
 https://docs.microsoft.com/azure/devops/pipelines/languages/python

yml file: (https://github.com/pikukesar/flask-ml-azure-serverless-demo/blob/main/azure-pipelines.yml)
              
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

How to improve the project in the future : Currectly the application works on a small data set which can be expanded to bigger data set or by caling service.
The application can be Integrated with other graphing softwares like tableau to give better visual rendering.




