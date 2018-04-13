# October CMS Starter Kit by LOVATA

## System requirements

1. OS Ubuntu 16.04 or higher
2. Apache 2
3. MySQL 5
4. PHP version 7.0 or higher
5. PDO PHP Extension
6. cURL PHP Extension
7. OpenSSL PHP Extension
8. Mbstring PHP Library
9. ZipArchive PHP Library
10. GD PHP Library


If you want to use this Starter kit in Windows or OSX use it with Vagrant. OSX native support will be available soon.

## Installation

### Step-by-step guide

This Starter kit includes a set of scripts for full automated install of  OctoberCMS and Webpack based frontend environment.

To start new October CMS project follow these steps:

1. Clone Starter kit repository using `git clone git@github.com:lovata/october-starter-kit.git` or `https://github.com/lovata/october-starter-kit.git`.

2. Setup you project in `bash/install/config.cfg` by specifying project settings:
```
PROJECT_NAME=mydomain.com       # domain name
PROJECTS_DIR=$HOME/myprojects   # directory
VIRTUALHOST_NAME=bootstrap.loc  # localhost address
DB_NAME="${PROJECT_NAME//.}"    # DB name
DB_USER=root                    # DB user
DB_PASSWORD=lovata              # DB user password
DB_CHARACTER_SET=utf8           # charset encoding
DB_COLLATION=utf8_general_ci    # collation
OCTOBER_GIT_INSTALL=            # set 'true' if you want to install October via Git
```

3. Run from terminal without root privileges `bash bash/install/install.sh` from project directory. Enter your sudo password when terminal asks for it.

4. Wait until install process is finished.

5. Do your job! ;)

### Installation bundle
1. October CMS
2. Webpack
3. PostCSS
4. Autoprefixer
5. Babel
6. CSSO
7. ESLint
8. StyleLint

## Usage

### Webpack build commands

1. `npm run build:prod` for production (minification, uglification)
2. `npm tun build:dev` for development (sourcemaps)
3. `npm run build:watch` for watching changes (development)
4. `npm run build:clean` to clean assets (=dist) folder
