# Meant for use for ACI Cloud Bootcamp (freeradius docker-compose on Azure VM)


  authorize file is in ~/aciCloudABC-FreeRadius/raddb/mods-config/files

 radius secret for this setup is:     sharedSecret    # defined in /etc/raddb/clients.conf <br>
 use radcrypt utilitiy for encrypting passwords:     radcrypt admin123       in this instance, I got fMB90CRSHkyQU <br>
 Test with radcrypt -c admin123 fMB90CRSHkyQU         you will see "Password O.K." <br>

 after install Test from base host: radtest admin admin123 localhost 1812 sharedSecret          # you will get back an answer if it's working <br>

 Note:   it's best to combine the MSO and ACI  AVPairs like this:  Cisco-AVPair = "shell:domains =all/admin/,msoall/powerUser/"   # this is after 3.1.x of MSO, othewise it won't work.  This was made for SSO capability on ND. <br>
 Please see: https://unofficialaciguide.com/2020/12/28/upgrading-aci-fabric-and-mso-please-read-this-first/  <br>

 Old Method is show below:   DO NOT DO THIS: <br>
        #Cisco-AVPair = "shell:domains =all/admin/",   # this is the old style pre 3.1.x MSO,  will not work any more <br>
        #Cisco-AVPair += "shell:msc-roles=powerUser/", # this is the old stye pre 3.1.x MSO, will not work any more <br>
<br>
 Remember to use docker-compose restart everytime you make a change in the AVPairs. ( do this from the directory that has the docker-compose.yaml file) <br>



# Below not applicable. Using Terraform Main Module to do everything automatically
#  How to Install:  <br>
   Clone this repo <br>
   cd to the directory where docker-compose.yaml file is:  ~/aciCloudABC-FreeRadius <br>
   sudo docker-compose up --build -d  <br>

