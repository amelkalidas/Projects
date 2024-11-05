# CI-CD 1
CI-CD pipeline for Webpage deployment


![image](https://github.com/amelkalidas/CICD1/assets/93365624/f4cb4795-4fd8-4722-8153-2fc13682f45d)






This project is focused to help in continous development of the application. There are two stages to the project. 

# Testing and # Producion Stage.

Tools user :
Master Node is configured to act as Ansible and Jenkins Controller.
Node1 act as Testing Stage for the application deployment.
Node2 act as the Production Stage for the application Deployment.

1. Terraform
2. GIT
3. Ansible
4. Jenkin
5. Docker
6. AWS Cloud
7. JDK

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Infrastrucuture Deployment using : Terraform [Devopscapstone.tf](https://github.com/amelkalidas/CICD1/blob/main/devopscapstone.tf) 


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Application installation Files on Various Servers.

For Ansible Installation on Master used. we can use [Ansibleinstallation.sh](https://github.com/amelkalidas/CICD1/blob/main/ansibleinstallation.sh)

We can configure the Nodes to communicate with Ansible controller using SSH.
1. SSH-Keygen on AnsibleMasterNode.
2. Copy paste the Public Key to Both Nodes ~/.ssh/authorized_keys file.

I have created Two script files to install Application on Nodes as well as Master Node.

1. Master Node: [Master.sh](https://github.com/amelkalidas/CICD1/blob/main/master.sh)
     a. Ansible
     b. Jenkins
     c. Java
2. Nodes ( Test and Prod ): [Nodes.sh](https://github.com/amelkalidas/CICD1/blob/main/Nodes.sh)
     a. Docker
     b. java ( Jenkin requirement )

Using Ansible Playbook we can autoamte the deployment of application to Nodes and Local host at ease. 
prerequisites  : within the installation directory of Ansible ( /et/ansible ) we would need to add the Private/PublicIp of the Nodes.
[Nodes]
Node1-PrivateIp  
Node2-PriavateIp 

AnsiblePlaybook : [Ansibleplay.yaml](https://github.com/amelkalidas/CICD1/blob/main/ansibleplay.yaml)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Jenkins

Using Jenkins we can automate the Lifecycle of application deployment.

Within Jenkins Console, we can create Two Nodes 

  Node1 - Testing  ( Label - Testnode )
  Node2 - Production ( Label - prodnode )

Node intergration with Jenkin can be achieved using SSH or Remoting. 
![image](https://github.com/amelkalidas/CICD1/assets/93365624/8efa024e-505f-4f6e-8242-4c0818417db5)


Once Nodes are setup we can configure Pipelines.
1. Job 1 - Once commit is made to Develop branch - Build and Test the application on Test Node. [Pipeline1-Test](https://github.com/amelkalidas/CICD1/blob/main/pipeline-Test%20%7B.groovy)
2. Job 2 - Once commit is made to Master Branch - Build and Test the application on Test Node again. [Pipeline2 ]([url](https://github.com/amelkalidas/CICD1/blob/main/pipeline%20-Job2%7B.groovy))
3. Job 3 - Once the above Build is completed ( only if completed ) Build and Publish the app on Prod Node.[Pipeline 3 ]([url](https://github.com/amelkalidas/CICD1/blob/main/pipeline-Job3%20%7B.groovy)https://github.com/amelkalidas/CICD1/blob/main/pipeline-Job3%20%7B.groovy)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Testing 

1. Job 1 Testing - PublicIP of Node1:82
2. Job 2 Testing - Public IP of Node1:81
3. Job 3 Testing - Public IP of Node2 ( Production ):80 
