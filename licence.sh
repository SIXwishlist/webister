echo "Licencing Product... (This may take a while)"
echo "This is normal, just in case we plan to add a paid version, this will be used."
A="$(openssl rand -base64 12)-$(openssl rand -base64 12)-$(openssl rand -base64 12)-$(openssl rand -base64 12)"
echo "$A" > application/tmp/webister/licence-key
echo "Licence Key is:"
echo "$A"
echo "Press Any Key to Continue"
read pa
cd application/tmp/webister/ && zip -r --password "$A" interface.zip install.php interface website files && cd ../../../




