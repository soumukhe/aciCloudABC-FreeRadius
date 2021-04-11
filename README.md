# freeradius docker-compose on Azure VM
# Meant for use for ACI Cloud Bootcamp 
Remember the Azure VM with Radius Installed was spun up by Terraform by cloning my git repo: https://github.com/soumukhe/azurerm-vmmain.git and doing terraform init and terraform apply.   


  # authorize file is where you define users and avPairs: <br>
  1. ssh in to the azure VM.   ssh -i sshPrivKeyName azureuser@azureVM_ip   To find the IP, please go to the Terraform Directory "azurerm-vmmain" (on your local mac)  and do terraform output <br>
  2. cd aciCloudABC-FreeRadius  (this is on the Azure VM)<br>
  3. make your encrypted password that you will use. e.g.  "radcrypt admin123"  or   "radcrypt yourUserName YourDesiredPassword" <br>
  4. vi ~/aciCloudABC-FreeRadius/raddb/mods-config/files/authorize   Make sure to use the encrypted password from step 3 above. <br>
  5. docker-compose restart <br>
  

 # radius secret for this setup is:     sharedSecret    
 This radius secret is defined in /etc/raddb/clients.conf in the container.  If you wanted to take a look please go into the conatiner and look.  "docker exec -it sm-radius /bin/bash"  will get you inside the container. <br>
 
 Also note that on the base Azure VM,  the directory ~/aciCloudABC-FreeRadius/raddb  is mapped to /etc/raddb inside the container,  If you look at docker-compose.yml this will become evident <br>
 
 # Making Encrypted Password <br>
 use radcrypt utilitiy for encrypting passwords:     radcrypt admin123       in this instance, I got fMB90CRSHkyQU <br>
 
 # Testing to make sure your encryted password is what your plain text is: <br>
 Test with radcrypt -c admin123 fMB90CRSHkyQU         you will see "Password O.K." <br>

 # Testing quickly to make sure that radius server is returning correct avApair: <br>
 radtest admin admin123 localhost:1812 1812 sharedSecret          # you will get back an answer if it's working <br>

# New Style AvPair:   (note that for MSO, "msc-roles" is not valid any more.  The new one is "msoall")
 Note:   it's best to combine the MSO and APIC  AVPairs like this:  Cisco-AVPair = "shell:domains =all/admin/,msoall/powerUser/"   # this is after 3.1.x of MSO, 
  This was made for SSO capability on ND. <br>
 If you want to do single line method, you can, but you have to do it in a specific order:  Please see: https://unofficialaciguide.com/2020/12/28/upgrading-aci-fabric-and-mso-please-read-this-first/  <br>

# Old AvPair method is show below:   DO NOT DO THIS: <br>
        Cisco-AVPair = "shell:domains =all/admin/",   # this is the old style pre 3.1.x MSO,  will not work any more 
        Cisco-AVPair += "shell:msc-roles=powerUser/", # this is the old stye pre 3.1.x MSO, will not work any more 
<br>
# Remember to use "docker-compose restart" everytime you make a change in the AVPairs. ( do this from the directory that has the docker-compose.yaml file) <br>



# Below not applicable for Cloud ACI Bootcamp. In the bootcamp, we are using Terraform Main Module azurerm-vmmain to do everything automatically 
i.e.  install Ubuntu on Azure Cloud, update Ubuntu and install dependencies, install docker and docker compose, clone this freeradius repo from git and spin up the radius container.
#  How to Install:  <br>
   Clone this repo on your Azure VM or any Ubuntu VM <br>
   cd to the directory where docker-compose.yaml file is:  ~/aciCloudABC-FreeRadius <br>
   sudo docker-compose up --build -d  <br>

