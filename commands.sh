
python3 -m venv ~/.flask-ml-azure
source ~/.flask-ml-azure/bin/activate
cd flask-ml-azure-serverless-demo
make install
az webapp up -n flask-ml-service-pkesarwani

##OUTPUT
{
  "URL": "http://flask-ml-service-pkesarwani.azurewebsites.net",
  "appserviceplan": "udacityprashants_asp_Linux_southcentralus_0",
  "location": "southcentralus",
  "name": "flask-ml-service-pkesarwani",
  "os": "Linux",
  "resourcegroup": "udacityprashants_rg_Linux_southcentralus",
  "runtime_version": "python|3.7",
  "runtime_version_detected": "-",
  "sku": "PREMIUMV2",
  "src_path": "//home//prashnat//flask-ml-azure-serverless-demo"
}


