#!sh

[ -z "$TARGET_USER" ] && TARGET_USER="$USER"
[ -z "$TARGET_GROUP" ] && TARGET_GROUP="$TARGET_USER"
[ -z "$TARGET_DIRECTORY" ] && TARGET_HOME="$(eval echo ~"$TARGET_USER")"
TARGET_DIRECTORY="$TARGET_HOME"/.zsh.d

[ -d "$TARGET_DIRECTORY" ] && exit 0

set -e
WORKDIR=/tmp/$RANDOM$RANDOM # not cryptographically secure!
mkdir $WORKDIR
cd $WORKDIR
curl -Lfs https://github.com/yaniv-aknin/zsh_config/tarball/master | tar zx
mv yaniv-aknin-zsh_config-* "$TARGET_DIRECTORY"
"$TARGET_DIRECTORY"/install.sh "$TARGET_HOME"
if [ "$USER" != "$TARGET_USER" ]; then
    chown -R "$TARGET_USER:$TARGET_GROUP" "$TARGET_DIRECTORY" "$TARGET_HOME"/.zshrc
fi
rm -fr $WORKDIR
set +e
