# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
# Clear the color after that
clear='\033[0m'
#bold colors
bld_red='\033[1;31m'
bld_green='\033[1;32m'
bld_yellow='\033[2;33m'
bld_blue='\033[1;34m'
bld_magenta='\033[1;35m'
bld_cyan='\033[1;36m'
bld_white='\033[1;37m'
#background colors
bg_red='\033[0;41m'
bg_green='\033[0;42m'
bg_yellow='\033[0;43m'
bg_blue='\033[0;44m'
bg_magenta='\033[0;45m'
bg_cyan='\033[0;46m'
#text bold
bold=`tput bold`
offbold=`tput rmso`
printf  "${green}Entering the Script file...${clear}\n"
#Run the following commands to get information on the newest versions of packages and their dependencies and update them
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt autoremove -y
printf "\n${green}Successfully Updated...!${clear}\n"
#Node.js is an open source, cross-platform runtime environment for developing server-side and networking applications. Node.js applications are written in JavaScript, and can be run within the Node.js runtime on OS X, Microsoft Windows, and Linux.
printf "${yellow}Installing nodejs${clear}\n"
sudo apt install -y curl
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
printf "${yellow}Installing required resources...${clear}\n"
#python-dev is the package that contains the header files for the Python C API, which is used by lxml because it includes Python C extensions for high performance.
#Setuptools is a collection of enhancements to the Python distutils that allow developers to more easily build and distribute Python packages, especially ones that have dependencies on other packages.
#Packages built and distributed using setuptools look to the user like ordinary Python packages based on the distutils.
#pip is a package manager for Python.
#It’s a tool that allows you to install and manage additional libraries and dependencies that are not distributed as part of the standard library.
sudo apt install -y nodejs mariadb-server redis-server python3-pip nginx python3-testresources
printf "${bold}${green}Resources Installed...!${offblod}${clear}\n"
#During this installation you'll be prompted to set the MySQL root password.
#If you are not prompted, you'll have to initialize the MySQL server setup yourself.
#It is really important that you remember this password, since it'll be useful later on.
#You'll also need the MySQL database development files
#MariaDB is developed as open source software and as a relational database it provides an SQL interface for accessing data.
sudo rm -rf /etc/mysql/my.cnf
sudo cp -r my.cnf /etc/mysql/
printf "${green}Changed mysql configuration...${clear}\n"
sudo systemctl restart mysql
printf "${blue}Mysql service restarted....${clear}\n"
#IMPORTANT :During this installation you’ll be prompted to set the MySQL root password.
#If you are not prompted for the same You can initialize the MySQL server setup by executing the following command
sudo mysql -uroot -p << EOF
alter user root@localhost identified by 'Frappe@123';
EOF
printf "${bg_yellow}Mysql DB root password Frappe@123${clear}\n"
#Yarn is a JavaScript package manager that aims to be speedy, deterministic, and secure.
#See how easy it is to drop yarn in where you were using npm before, and get faster, more reliable installs.
#Yarn is a package manager for JavaScript.
sudo npm install -g yarn
printf "${yellow}Installing Frappe-Bench${clear}"
sudo pip3 install frappe-bench
sudo systemctl restart mariadb
sudo pip3 install frappe-bench
printf "${green}Installing bench components...!${clear}\n"
sudo -H pip3 install frappe-bench
#Git is the most commonly used version control system.
#Git tracks the changes you make to files, so you have a record of what has been done, and you can revert to specific versions should you ever need to.
#Git also makes collaboration easier, allowing changes by multiple people to all be merged into one source.
sudo apt install git -y
#virtualenv is a tool for creating isolated Python environments containing their own copy of python , pip , and their own place to keep libraries installed from PyPI.
#It’s designed to allow you to work on multiple projects with different dependencies at the same time on the same machine.
sudo apt install python3.8-venv -y
cd ~
bench init --frappe-branch version-13 frappe-bench
cd frappe-bench
#bench get-app --branch version-13 erpnext
bench new-site frappe-site
bench use frappe-site
me=$(whoami)
printf "${yellow}Stopping nginx service...!${clear}\n"
sudo service nginx stop
#After the frappe-bench folder is created, changing your directory run bench
cd ~
cd frappe-bench
printf "${yellow}Getting ERPNext...${clear}\n"
#Get ERPNext application from GitHub
#Download the ERPNext application from frappe Github repo.
#We will get version 13.
#The get-app command gets remote frappe apps from a remote git repository and installs them. Example: erpnext
bench get-app --branch version-13 erpnext
#You can get whichever version you like.
printf "${yellow}Installing ERPNext...${clear}\n"
bench --site frappe-site install-app erpnext
#Frappe apps are run by frappe sites and you will have to create at least one site. The new-site command allows you to do that.
bench use frappe-site
printf "\n\n${green} ALL SETUPS ARE COMPLETED....!${clear}\n"
#To start using the bench, use the bench start command
sudo cp -r production-mode.sh /home/
sudo chmod a+x /home/production-mode.sh
sh production-setup.sh
printf "${yellow}Project Starting...${clear}\n"
bench start
