set -x
REPO="git@github.com:wojciechdrabczyk/flake.git"
git remote -v
git remote rm origin
git remote add origin $REPO
git fetch
git branch -u origin/main
echo "Changed repository path to $REPO"