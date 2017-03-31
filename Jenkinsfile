node {
   stage 'build'
   sh 'rm -rf webister && git clone https://github.com/alwaysontop617/webister.git'
   sh 'cd webister && cp -R * ../'
   sh 'echo "Compiling Packages..."'
   sh 'dpkg-deb --build application'
   
   stage 'req'
   sh 'wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.1.2/php-cs-fixer.phar -O php-cs-fixer'
   parallel 'test': {
   sh 'wget https://raw.githubusercontent.com/alwaysontop617/webister/master/test.sh'
   sh 'sh test.sh > logtest.txt'
   sh 'curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar'
   sh 'php phpcs.phar --report-diff=report.diff --ignore=*adminer* --encoding=utf-8 --severity=3 --extensions=php -n -p -l -v application/tmp/webister/interface/ > logstyle.txt || :'
   }
   
   stage 'md5'
   sh 'md5sum logtest.txt logstyle.txt application.deb report.diff> md5.txt'
   
   stage 'patch'
   sh 'cp -R application patch'
   sh 'rm -rf patch/DEBIAN/postinst'
   sh 'rm -rf patch/tmp/webister/interface/config.php'
   sh 'echo "cp -R /tmp/webister/interface/ /var/webister/interface" > application/DEBIAN/postinst'
   sh 'dpkg-deb --build patch'
   
   stage 'archive'
   archive 'application.deb'
   archive 'patch.deb'
   archive 'logtest.txt'
   archive 'logstyle.txt'
   archive 'md5.txt'
   archive 'report.diff'
   
   stage 'clean'
   sh 'rm -rf *'
}

