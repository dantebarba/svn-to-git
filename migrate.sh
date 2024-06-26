#!/bin/bash
set -e

####### Project name 
PROJECT_NAME="${PROJECT_NAME:-myproject}"
EMAIL="${EMAIL:-mycompany.com}"
# SVN
# SVN repository to be migrated
BASE_SVN="${BASE_SVN:-http://svn.mycompany.com/svn/repo/sistemas/$PROJECT_NAME}"

# Organization inside BASE_SVN
BRANCHES="${BRANCHES:-branches}"
TAGS="${TAGS:-tags}"
TRUNK="${TRUNK:-trunk}"

###########################
#### Don't need to change from here
###########################

#STYLE_COLOR
RED='\033[0;31m';
LIGHT_GREEN='\e[1;32m';
NC='\033[0m' # No Color


# Geral Configuration
ABSOLUTE_PATH="${ABSOLUTE_PATH:-$(pwd)}"
TMP=$ABSOLUTE_PATH/"migration-"$PROJECT_NAME

# Branchs Configuration
SVN_BRANCHES=$BASE_SVN/$BRANCHES
SVN_TAGS=$BASE_SVN/$TAGS
SVN_TRUNK=$BASE_SVN/$TRUNK

AUTHORS="authors.txt"

echo -e "${LIGHT_GREEN} [LOG] Starting migration of ${NC}" $SVN_TRUNK
echo -e "${LIGHT_GREEN} [LOG] Using: ${NC}" $(git --version)
echo -e "${LIGHT_GREEN} [LOG] Using: ${NC}"  $(svn --version | grep svn,)
echo
echo
echo -e "${LIGHT_GREEN} [LOG] Step 01/08 Create Directories ${NC}" $TMP


mkdir $TMP
cd $TMP

echo
echo -e "${LIGHT_GREEN} [LOG] Step 02/08 Getting authors ${NC}"
svn log -q $BASE_SVN | awk -F '|' '/^r/ {sub("^ ", "", $2); sub(" $", "", $2); print $2" = "$2" <"$2"@'"$EMAIL"'>"}' | sort -u >> $AUTHORS

echo
echo -e "${LIGHT_GREEN} [RUN] Step 03/08"
echo 'git svn clone --log-window-size=100000 --authors-file='$AUTHORS' --trunk='$TRUNK' --branches='$BRANCHES' --tags='$TAGS $BASE_SVN $TMP
echo -e "${NC}"

git svn clone --log-window-size=100000 --authors-file=$AUTHORS --trunk=$TRUNK --branches=$BRANCHES --tags=$TAGS $BASE_SVN $TMP

echo
echo -e "${LIGHT_GREEN} [LOG] Step 04/08  Getting first revision ${NC}"
FIRST_REVISION=$( svn log -r 1:HEAD --limit 1 $BASE_SVN | awk -F '|' '/^r/ {sub("^ ", "", $1); sub(" $", "", $1); print $1}' )

echo
echo -e "${LIGHT_GREEN} [RUN] Step 05/08 ${NC}"
echo 'git svn --log-window-size=100000 fetch -'$FIRST_REVISION':HEAD'
git svn --log-window-size=100000 fetch -$FIRST_REVISION:HEAD

echo
echo -e "${LIGHT_GREEN} [RUN] Step 06/08 ${NC}"
echo 'svn ls '$SVN_BRANCHES

for BRANCH in $(svn ls $SVN_BRANCHES); do
    echo git branch ${BRANCH%/} remotes/origin/${BRANCH%/}
    git branch ${BRANCH%/} remotes/origin/${BRANCH%/}
done

git for-each-ref --format="%(refname:short) %(objectname)" refs/remotes/origin/tags | grep -v "@" | cut -d / -f 3- |
while read ref
do
  echo git tag -a $ref -m 'import tag from svn'
  git tag -a $ref -m 'import tag from svn'
done

git for-each-ref --format="%(refname:short)" refs/remotes/origin/tags | cut -d / -f 1- |
while read ref
do
  git branch -rd $ref
done

echo 'Sucessufull.'
