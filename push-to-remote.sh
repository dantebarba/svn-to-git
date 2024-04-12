#!/bin/sh

#STYLE_COLOR
RED='\033[0;31m';
LIGHT_GREEN='\e[1;32m';
NC='\033[0m' # No Color

###########################
####### GIT 
# Git repository to migrate
GIT_URL="${GIT_URL:-https://git.mycompany.com/git/repo/sistemas/$PROJECT_NAME.git}"

echo
echo -e "${LIGHT_GREEN} [RUN] Step 07/08 ${NC}"
echo 'git remote add origin '$GIT_URL
git remote add origin $GIT_URL

echo
echo -e "${LIGHT_GREEN} [RUN] Step 08/08 [RUN] git push ${NC}"
git push origin --all --force
git push origin --tags

echo "Pushed to remote"
