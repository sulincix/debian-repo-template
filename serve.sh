curdir=$(pwd)
cd srv
python3 -m http.server 8080
cd $curdir
