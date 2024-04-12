#!/bin/sh
###########################
####### GIT 
# Git repository to migrate
GIT_URL="https://git.mycompany.com/git/repo/sistemas/myproject.git"

echo
echo -e "${LIGHT_GREEN} [RUN] Step 07/08 ${NC}"
echo 'git remote add origin '$GIT_URL
git remote add origin $GIT_URL

echo
echo -e "${LIGHT_GREEN} [RUN] Step 08/08 [RUN] git push ${NC}"
git push origin --all --force
git push origin --tags

echo "Pushed to remote"
