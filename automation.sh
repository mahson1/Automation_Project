apt update -y
my_string="apache2"

echo "outside if"
if [[ -z $(ps -ef |grep ${my_string}) ]]
then
   echo "Need to install apach2 as its missing"
   apt install apache2;
   systemctl enable apache2;
   systemctl restart apache2;
   systemctl status apache2;
else
   echo "Apache2 is already running"
   systemctl status apache2;
fi


#define the today time
DATE=`date +%Y%m%d%H%M%S`


#compress the nohup.out file to a special directory
gzip -c /var/log/apache2/access.log  > /tmp/apache_${DATE}.log.gz
aws s3 mv /var/log/apache2/apache_*.gz s3://upgrad-mahendra-sonawale
